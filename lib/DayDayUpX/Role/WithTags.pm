use MooseX::Declare;

# c-p http://github.com/jrockway/pleasurechicken/tree/master
role DayDayUpX::Role::WithTags {
    
    our $VERSION = '0.91';
    
    use MooseX::Types::Set::Object;

    has 'tag_set' => (
        is       => 'ro',
        isa      => "Set::Object",
        required => 1,
        default  => sub { [] },
        handles  => {
            'tags'    => 'members',
            'add_tag' => 'insert',
        },
    );
}

1;
