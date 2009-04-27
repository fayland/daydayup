package DayDayUp::Index;

use strict;
use warnings;

our $VERSION = '0.07';

use base 'Mojolicious::Controller';

sub index {
    my ($self, $c) = @_;

    $c->render(template => 'index/index.html' );
}

1;
__END__

=head1 NAME

DayDayUp::Index - Mojolicious::Controller, /

=head1 URL

	/

=head1 AUTHOR

Fayland Lam < fayland at gmail dot com >

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut