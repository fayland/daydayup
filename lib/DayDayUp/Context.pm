use MooseX::Declare;

class DayDayUp::Context extends Mojolicious::Context is mutable {
    use MooseX::Types::Moose qw(Str);
    
    our $VERSION = '0.09';
    
    # shortcuts
    method log  { $self->app->log };
    method home { $self->app->home };
};

1;
