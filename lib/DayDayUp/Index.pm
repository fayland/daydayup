package DayDayUp::Index; # make CPAN happy

use MooseX::Declare;

class DayDayUp::Index extends Mojolicious::Controller is mutable {

    method index ($c) {
        $c->render(template => 'index/index.html' );
    }
};

1;
