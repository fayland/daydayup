use MooseX::Declare;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
role DayDayUpX::Role::WithTags {
    use DayDayUpX::Types qw(Tag Set);
    use KiokuDB::Util qw(weak_set);

    has 'tag_set' => (
        is       => 'ro',
        isa      => Set,
        required => 1,
        default  => sub { weak_set() },
        handles  => {
            'tags'    => 'members',
        },
    );

    method add_tag(Tag $tag) {
        $self->tag_set->insert($tag);
        $tag->applied_to_set->insert($self);
    }
}

1;
