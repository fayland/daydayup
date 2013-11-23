package DayDayUpX::Tag; # make CPAN happy

use mop;

sub type {
    if ($_[0]->isa('mop::attribute')) {
        my ($attr, $type) = @_;
        $attr->bind('before:STORE_DATA' => sub { $type->assert_valid( ${ $_[2] } ) });
    }
    elsif ($_[0]->isa('mop::method')) {
        my ($meth, @types) = @_;
        mop::apply_metarole($meth, 'TypedMethod');
        $meth->arg_types(\@types);
    }
}

class DayDayUpX::Tag {

    our $VERSION = '0.96';
    use Types::Standard qw/Str/;

    has $!name is rw, required, type(Str);
};

1;