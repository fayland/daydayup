use MooseX::Declare;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
class DayDayUpX::Tag {
    
    our $VERSION = '0.91';
    
    use MooseX::Types::Moose qw(Str);
    
    has 'name' => (
        is  => 'rw',
        isa => Str,
        required => 1,
    );
};

1;