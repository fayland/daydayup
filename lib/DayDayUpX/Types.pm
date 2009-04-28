package DayDayUpX::Types;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
use strict;
use warnings;

use MooseX::Types -declare => [ qw{
    Taggable
    Tag
    Set
}];

use MooseX::Types::Moose qw(Str Object);
use KiokuDB::Set;

subtype Taggable, as Object, where {
    $_->does('DayDayUpX::Role::WithTags');
};

class_type 'DayDayUpX::Tag';
subtype Tag, as 'DayDayUpX::Tag';

subtype Set, as Object, where { $_->does('KiokuDB::Set') };

1;
