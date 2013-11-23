package DayDayUp::Extra; # make CPAN happy

use mop;

role DayDayUp::Extra {

    our $VERSION = '0.95';

    use MooseX::Types::Moose qw(Str);
    use YAML qw/LoadFile/;
    use KiokuDB;

    # shortcuts
    method app_class { $self->home->app_class };

    # config
    has $!config is lazy, rw = $_->_build_config;
    method _build_config {
        my $app  = $self->app_class;
        my $file = $self->home->rel_file( lc($app) . '.yml' );
        my $config = YAML::LoadFile($file);
        return $config;
    };

    has $!kiuku is lazy, rw = $_->_build_kioku;
    method _build_kioku {
        my @kioku_config = $!config->{kioku} ? @{ $config->{kioku} } : (
            "dbi:SQLite:dbname=" . $self->home->rel_file( lc($self->app_class) . '.sqlite' ),
            create => 1
        );
        return KiokuDB->connect(@kioku_config);
    }

};

1;
