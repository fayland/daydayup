use MooseX::Declare;

class DayDayUpX::Tag {
    use MooseX::Types::Moose qw(Str);
    
    has 'text' => (
        is  => 'rw',
        isa => Str,
        required => 1,
    );

};

1;