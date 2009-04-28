use MooseX::Declare;

class DayDayUpX::Tag {
    
    our $VERSION = '0.91';
    
    use MooseX::Types::Moose qw(Str);
    
    has 'text' => (
        is  => 'rw',
        isa => Str,
        required => 1,
    );

};

1;