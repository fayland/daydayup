package DayDayUpX::Types;

# c-p http://github.com/jrockway/pleasurechicken/tree/master

use strict;
use warnings;

our $VERSION = '0.91';

use MooseX::Types -declare => [ qw{
    Set
}];

use MooseX::Types::Moose qw(Object);
use KiokuDB::Set;

subtype Set, as Object, where { $_->does('KiokuDB::Set') };

1;
