package DayDayUp::Perl;

use strict;
use warnings;

use base 'Mojolicious::Controller';

our $VERSION = '0.08';

use File::Slurp ();
use Data::Dumper;
use LWP::Simple qw/head/;

use constant IS_WIN32 => !! ( $^O eq 'MSWin32' );

sub index {
    my ($self, $c) = @_;
    
    $c->render(template => 'perl/index.html', IS_WIN32 => IS_WIN32);
}

sub find_pod {
	my ($self, $c) = @_;
	
	my $params = $c->req->params->to_hash;
	my $module = $params->{module};
	
	my $stash = { template => 'perl/index.html', from => 'find_pod', IS_WIN32 => IS_WIN32 };
	if ( $module ) {
		# find the HTML place of a module
		my $pod = `perldoc $module`;
		$stash->{content} = $pod;
	}
	
	$c->render( $stash );
}

sub view_source {
	my ($self, $c) = @_;
	
	my $params = $c->req->params->to_hash;
	my $module = $params->{module};

	my $stash = { template => 'perl/index.html', from => 'view_source', IS_WIN32 => IS_WIN32 };
	if ( $module ) {
		# find the HTML place of a module
		my $file = `perldoc -l $module`;
		#$c->app->log->debug("perldoc -l $module return $file");
		my $code = "Can't find $module";
		if ( $file ) {
			chomp( $file );
			$code = eval { File::Slurp::read_file($file, binmode => ':raw') };
			$code = "# $file\n\n$code";
			$code = $@ if $@;
		}
		$stash->{content} = $code;
	}
	
	$c->render( $stash );
}

our $repos = {
	'v5.08' => [  # 5.008006
		'http://trouchelle.com/ppm/',
		'http://ppm.tcool.org/archives/',
	],
	'v5.10' => [ # 5.010000
		'http://trouchelle.com/ppm10/',
		'http://ppm.tcool.org/archives510/',
	],
};
sub find_ppd {
	my ( $self, $c ) = @_;
	
	# get the perl version
	my $pversion = $^V;
	$pversion = substr( $pversion, 0, 5 );
	
	my $stash = {
		template => 'perl/index.html',
		from => 'find_ppd',
		IS_WIN32 => IS_WIN32
	};
	
	my $params  = $c->req->params->to_hash;
	my $module  = $params->{module};
	my $install = $params->{install};
	
	# to Mojo-X-Y.ppd
	$module =~ s/\:\:/\-/g;
	$module .= '.ppd';
	
	# wget
	my $content;
	foreach my $rep ( @{ $repos->{$pversion} } ) {
		my $url = $rep . $module;
		if ( head( $url ) ) {
			$content = "ppm install $url\n\n";
			$content .= `ppm install $url` if ( $install );
			last;
		}
	}
	$content = "Can't find anything with repos: \n    " . join("\n    ", @{ $repos->{$pversion} } ) . "\nPerl Version: $pversion\n" unless $content;
	$stash->{content} = $content;
	$c->render( $stash );
}

1;
__END__

=head1 NAME

DayDayUp::Perl - Mojolicious::Controller, /perl/

=head1 URL

	/perl/
	/perl/find_pod
	/perl/view_source

=head1 AUTHOR

Fayland Lam < fayland at gmail dot com >

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
