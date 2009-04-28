use MooseX::Declare;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
role DayDayUpX::Role::WithTags {
    use DayDayUpX::Types qw(Set);
    use KiokuDB::Util qw(weak_set);
    
    our $VERSION = '0.91';

    has 'tag_set' => (
        is       => 'ro',
        isa      => Set,
        required => 1,
        default  => sub { weak_set() },
        handles  => {
            'tags'    => 'members',
            'add_tag' => 'insert',
        },
    );
}

1;
