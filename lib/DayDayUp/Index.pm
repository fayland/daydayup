use MooseX::Declare;

class DayDayUp::Index extends Mojolicious::Controller is mutable {

    our $VERSION = '0.09';
    
    method index ($c) {
        $c->render(template => 'index/index.html' );
    }
};

1;
