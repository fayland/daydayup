use MooseX::Declare;

class DayDayUp::Notes extends Mojolicious::Controller is mutable {
    use DayDayUpX::Note;
    use DayDayUpX::Tag;
    
    our $VERSION = '0.91';
    
    method index ($c) {
        
        my $notes;
        
        my $kioku = $c->kioku;
        my $scope = $kioku->new_scope;
        my $all = $kioku->backend->all_entries;
        while( my $chunk = $all->next ){
            entry: for my $id (@$chunk) {
                my $entry = $kioku->lookup($id->id);
                next entry unless blessed $entry && $entry->isa('DayDayUpX::Note');
                $entry->{id} = $id->id; # hack
                push @{ $notes->{ $entry->status} }, $entry;
            }
        }
        
        # sort by time DESC
        foreach my $key ( keys %$notes ) {
            $notes->{$key}
                = [ sort { $b->time <=> $a->time } @{ $notes->{$key} } ];
        }

        $c->render(template => 'notes/index.html', notes => $notes );
    };
    
    method add ($c) {
        
        my $stash = {
            template => 'notes/add.html',
        };
        unless ( $c->req->method eq 'POST' ) {
            return $c->render( $stash );
        }
        
        my $config = $c->config;
        my $params = $c->req->params->to_hash;
        
        my $note = DayDayUpX::Note->new(
            text   => $params->{text},
            status => 'open',
            time   => time()
        );
        
        foreach my $tag_name ( split(/\s+/, $params->{tags} ) {
            $note->add_tag( DayDayUpX::Tag->new( name => $tag_name ) );
        }
        
        my $scope = $c->kioku->new_scope;
        $c->kioku->txn_do(sub {
            $c->kioku->insert($note);
        });

        $c->render(template => 'redirect.html', url => '/notes/');
    };
    
    method edit ($c) {

        my $captures = $c->match->captures;
        my $id = $captures->{id};
        
        my $kioku = $c->kioku;
        my $scope = $kioku->new_scope;
        my $note  = $kioku->lookup($id);

        my $stash = {
            template => 'notes/add.html',
        };
        unless ( $c->req->method eq 'POST' ) {
        	# pre-fulfill
        	$stash->{fif} = {
        		text => $note->text,
        	};
            return $c->render( $stash );
        }
        
        my $params = $c->req->params->to_hash;
        
        $note->text( $params->{text} );
        
        {
            my $scope = $kioku->new_scope;
            $kioku->txn_do(sub {
                $kioku->update($note);
            });
        }

        $c->render(template => 'redirect.html', url => '/notes/');
    };
    
    method delete ($c) {

        my $captures = $c->match->captures;
        my $id = $captures->{id};
        
        my $kioku = $c->kioku;
        my $scope = $kioku->new_scope;
        $kioku->delete($id);

        $c->render(template => 'redirect.html', url => '/notes/');
    };
    
    method update ($c) {
    	
    	my $captures = $c->match->captures;
        my $id = $captures->{id};
        
        my $params = $c->req->params->to_hash;
        
        my $kioku = $c->kioku;
        my $scope = $kioku->new_scope;
        my $note  = $kioku->lookup($id);
        
        my $status = $params->{status};
        if ( $status eq 'closed' or $status eq 'rejected' ) {
            $note->status( $status );
            $note->closed_time( time() );
        } else {
            $note->status( $status );
        }
        
        {
            my $scope = $kioku->new_scope;
            $kioku->txn_do(sub {
                $kioku->update($note);
            });
        }
        
        $c->render(template => 'redirect.html', url => '/notes/');
    };
    
    method view_all ($c) {

    	my $params = $c->req->params->to_hash;
    	my $status = $params->{status};
        
        my $notes;
        my $kioku = $c->kioku;
        my $scope = $kioku->new_scope;
        my $all = $kioku->backend->all_entries;
        while( my $chunk = $all->next ){
            entry: for my $id (@$chunk) {
                my $entry = $kioku->lookup($id->id);
                next entry unless blessed $entry && $entry->isa('DayDayUpX::Note');
                $entry->{id} = $id->id; # hack
                push @{ $notes }, $entry if $entry->status eq $status;
            }
        }

        $c->render(
    		template => 'notes/index.html',
    		notes => { $status => $notes },
    		is_in_view_all_page => 1,
    		status => $status,
    	);
    }
};

1;
