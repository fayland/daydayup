use MooseX::Declare;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
role DayDayUpX::Role::WithTags {
    
    our $VERSION = '0.91';
    
    use Set::Object;
    use MooseX::Types::Moose qw(Object);

    has 'tag_set' => (
        is       => 'ro',
        isa      => Object,
        required => 1,
        default  => sub { Set::Object->new },
        handles  => {
            'tags'    => 'members',
            'add_tag' => 'insert',
        },
    );
}

1;
