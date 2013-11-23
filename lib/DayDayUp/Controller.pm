package DayDayUp::Controller; # make CPAN happy

use mop;

class DayDayUp::Controller extends Mojolicious::Controller {

    our $VERSION = '0.96';

    method redirect_tt($url) {
        $self->stash->{url} = $url;
        $self->render_tt( 'redirect.html' );
    }
};

1;
