use MooseX::Declare;

class DayDayUp::Notes extends Mojolicious::Controller is mutable {
    use DayDayUpX::Note;
    
    our $VERSION = '0.09';
    
    method index ($c) {
        
        my $notes;
        
        my $kioku = $c->kioku;
        my $scope = $kioku->new_scope;
        my $all = $kioku->backend->all_entries;
        while( my $chunk = $all->next ){
            entry: for my $id (@$chunk) {
                my $entry = $kioku->lookup($id->id);
                next entry unless blessed $entry && $entry->isa('DayDayUpX::Note');
                push @{ $notes->{ $entry->status} }, $entry;
            }
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
            text   => $params->{notes},
            status => 'open',
            time   => time()
        );
        
        my $scope = $c->kioku->new_scope;
        $c->kioku->txn_do(sub {
            $c->kioku->store($note);
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
        
        $note->text( $params->{note} );
        
        {
            my $scope = $kioku->new_scope;
            $kioku->txn_do(sub {
                $kioku->update($note);
            });
        }

        $c->render(template => 'redirect.html', url => '/notes/');
    }
};

1;

=pod




sub delete {
    my ( $self, $c ) = @_;
    
    my $captures = $c->match->captures;
    my $id = $captures->{id};
    
    my $dbh = $c->dbh;
    my $sql = q~DELETE FROM notes WHERE note_id = ?~;
    my $sth = $dbh->prepare($sql);
    $sth->execute( $id );
    
    $c->render(template => 'redirect.html', url => '/notes/');
}

sub update {
	my ( $self, $c ) = @_;
	
	my $captures = $c->match->captures;
    my $id = $captures->{id};
    
    my $dbh = $c->dbh;
    my $params = $c->req->params->to_hash;
    
    my $status = $params->{status};
    my $st_val = 2;
    foreach my $key ( keys %status ) {
    	if ( $status{ $key } eq $status ) {
    		$st_val = $key;
    		last;
    	}
    }
    
    if ( $status eq 'closed' or $status eq 'rejected' ) {
    	my $sql = q~UPDATE notes SET status = ?, closed_time = ? WHERE note_id = ?~;
		my $sth = $dbh->prepare($sql);
		$sth->execute( $st_val, time(), $id );
    } else {
		my $sql = q~UPDATE notes SET status = ? WHERE note_id = ?~;
		my $sth = $dbh->prepare($sql);
		$sth->execute( $st_val, $id );
    }
    
    $c->render(template => 'redirect.html', url => '/notes/');
}

sub view_all {
	my ( $self, $c ) = @_;
	
	my $dbh = $c->dbh;
	
	my $params = $c->req->params->to_hash;
	my $status = $params->{status};
    my $st_val = 0;
    foreach my $key ( keys %status ) {
    	if ( $status{ $key } eq $status ) {
    		$st_val = $key;
    		last;
    	}
    }
	
	my $sql = q~SELECT * FROM notes WHERE status = ? ORDER BY time DESC~; 
    my $sth = $dbh->prepare($sql);
    $sth->execute($st_val);
    my $notes = $sth->fetchall_arrayref({});
    
    $c->render(
		template => 'notes/index.html',
		notes => { $status => $notes },
		is_in_view_all_page => 1,
		status => $status,
		levels => \%levels
	);
}

1;
__END__

=head1 NAME

DayDayUp::Notes - Mojolicious::Controller, /notes/

=head1 URL

	/notes/
	/notes/add
	/notes/$id/edit
	/notes/$id/delete
	/notes/$id/update
	/notes/view_all

=head1 AUTHOR

Fayland Lam < fayland at gmail dot com >

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
