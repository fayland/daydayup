# package DayDayUp; # make CPAN happy

use mop;

class DayDayUp extends Mojolicious with DayDayUp::Extra {

    our $VERSION = '0.96';

    use File::Spec ();
    use Template::Stash::XS ();
    # use MojoX::Fixup::XHTML;

    # after dispatch($c) {
    #     MojoX::Fixup::XHTML->fix_xhtml( $c );
    # }

    # This method will run once at server start
    method startup {
        my $r = $self->routes;
        $r->route('/notes/:id/:action', id => qr/[\w\-]+/)
          ->to(controller => 'notes', action => 'index');
        # Default route
        $r->route('/:controller/:action')
          ->to(controller => 'notes', action => 'index');

        $self->plugin('charset' => {charset => 'UTF-8'});
        $self->plugin('tt_renderer' => {
            template_options => {
                COMPILE_DIR  => File::Spec->tmpdir(),
                POST_CHOMP   => 1,
                PRE_CHOMP    => 1,
                STASH        => Template::Stash::XS->new,
                INCLUDE_PATH => [ $self->home->rel_dir('templates') ],
                WRAPPER      => 'wrapper.html',
            }
        });
        $self->renderer->default_handler( 'tt' );
    }
};

1;
__END__

=head1 NAME

DayDayUp - good good study, day day up

=head1 DESCRIPTION

it B<is> just a test with L<Mojo> + L<KiokuDB> + L<mop>

but I do B<not> mind if you use it in your localhost (at your own risk).

=head1 RUN

    perl bin/day_day_up daemon

=head1 CONFIGURATION

create a daydayup_local.yml at the same dir as daydayup.yml

=head1 SEE ALSO

L<Mojo>, L<Mojolicious>, L<KiokuDB>, L<mop>

=head1 AUTHOR

Fayland Lam < fayland at gmail dot com >

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2009 Fayland Lam, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
