package DayDayUpX::Tag; # make CPAN happy

use mop;

class DayDayUpX::Tag {

    our $VERSION = '0.94';
    use MooseX::Types::Moose qw(Str);

    has 'name' => (
        is  => 'rw',
        isa => Str,
        required => 1,
    );
};

1;