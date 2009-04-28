use MooseX::Declare;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
role DayDayUpX::Role::WithTags {
    use KiokuDB::Util qw(weak_set);

    has 'tag_set' => (
        is       => 'ro',
        isa      => Object,
        required => 1,
        default  => sub { weak_set() },
        handles  => {
            'tags'    => 'members',
        },
    );

    method add_tag($tag) {
        $self->tag_set->insert($tag);
    }
}

1;
