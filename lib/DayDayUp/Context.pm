package DayDayUp::Context;

use Moose;

our $VERSION = '0.09';

extends 'Mojolicious::Context';

# shortcuts
sub log { shift->app->log }
sub home { shift->app->home }

1;
__END__

=head1 NAME

DayDayUp::Context - extends Mojolicious::Context

=head1 AUTHOR

Fayland Lam < fayland at gmail dot com >

=head1 COPYRIGHT AND LICENSE

Copyright 2009 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
