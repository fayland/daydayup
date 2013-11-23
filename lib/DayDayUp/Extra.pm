use mop;
role DayDayUp::Extra {

    our $VERSION = '0.95';

    use MooseX::Types::Moose qw(Str);
    use YAML qw/LoadFile/;
    use KiokuDB;

    # config
    has $!config is lazy = $_->_build_config();
    method _build_config {
        my $file = $self->home->rel_file( 'daydayup.yml' );
        my $config = YAML::LoadFile($file);
        return $config;
    };
    method config { $!config }

    has $!kioku is lazy = $_->_build_kioku();
    method _build_kioku {
        my @kioku_config = $!config->{kioku} ? @{ $config->{kioku} } : (
            "dbi:SQLite:dbname=" . $self->home->rel_file( 'daydayup.sqlite' ),
            create => 1
        );
        return KiokuDB->connect(@kioku_config);
    }
    method kioku { $!kioku }

};

1;
