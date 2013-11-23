package DayDayUpX::Note; # make CPAN happy

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

class DayDayUpX::Note with DayDayUpX::Role::WithTags {

    our $VERSION = '0.93';

    use Types::Standard qw(Str Int Enum);

    has $!text is rw, required, type(Str);
    # has $!NoteStatus is ro, type(Enum[qw(open closed rejected suspended)]);
    # has $!status is rw, type(isa => 'NoteStatus') = 'open';
    has $!status is rw = 'open';

    has $!time is rw, required, type(Int);
    has $!closed_time is rw, type(Int) = 0;
};

1;