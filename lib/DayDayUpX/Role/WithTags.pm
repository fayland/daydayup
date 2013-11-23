package DayDayUpX::Role::WithTags; # make CPAN happy

use mop;

role DayDayUpX::Role::WithTags {

    our $VERSION = '0.94';
    use DayDayUpX::Tag;

    has $!tags is rw = [];
    method clear_tags {
        $!tags = [];
    }

    method add_tag($name) {
        push @{$self->tags}, DayDayUpX::Tag->new( name => $name );
    };
};

1;