use MooseX::Declare;

class DayDayUpX::Note {
    use MooseX::Types::Moose qw(Str Int Enum);
    
    has 'text' => (
        is  => 'rw',
        isa => Str,
        required => 1,
    );
    
    has 'status' => (
        is  => 'rw',
        isa => Enum([qw(open closed rejected suspended)]),
        default => 'open',
    );
    
    has 'time' => (
        is => 'rw', isa => Int
    );
};

1;