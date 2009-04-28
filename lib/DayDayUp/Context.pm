use MooseX::Declare;

class DayDayUp::Context extends Mojolicious::Context is mutable {
    use MooseX::Types::Moose qw(Str);
    use YAML qw/LoadFile/;
    use KiokuDB;
    
    our $VERSION = '0.90';
    
    # shortcuts
    method log  { $self->app->log };
    method home { $self->app->home };
    method app_class { $self->home->app_class };
    
    # config
    has 'config' => (
        is   => 'ro',
        isa  => 'HashRef',
        lazy_build => 1,
    );
    method _build_config {
        my $app  = $self->app_class;
        my $file = $self->home->rel_file( lc($app) . '.yml' );
        my $config = YAML::LoadFile($file);
        return $config;
    };
    
    has 'kioku' => (
        is         => 'ro',
        isa        => 'KiokuDB',
        lazy_build => 1,
    );
    method _build_kioku {
        my $config  = $self->config;
        my @kioku_config = $config->{kioku} ? @{ $config->{kioku} } : (
            "dbi:SQLite:dbname=" . $self->home->rel_file( lc($self->app_class) . '.sqlite' )
        );
        return KiokuDB->connect(@kioku_config);
    }
    
};

1;
