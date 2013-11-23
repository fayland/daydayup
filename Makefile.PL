use inc::Module::Install;

name            ('DayDayUp');
author          ('Fayland Lam<fayland@gmail.com>');
abstract        ('DayDayUp - good good study, day day up');
license         ('perl');
version_from    ('lib/DayDayUp.pm');

repository 'http://github.com/fayland/daydayup/tree/master';

requires 'Mojolicious' => '4';
requires 'Moose'    => '0.89';
requires 'Template' => '2.20';
requires 'Template::Plugin::FillInForm';
requires 'Mojolicious::Plugin::TtRenderer' => '0.31';
# requires 'MojoX::Fixup::XHTML';
requires 'KiokuDB'  => '0.32';
requires 'KiokuDB::Backend::DBI' => '0.07';
requires 'DBD::SQLite' => '1.25';
requires 'mop';
#requires 'MooseX::Types' => '0.20';
requires 'YAML';

test_requires 'Test::More';

tests ( join ' ', ( glob('t/*.t'), glob('t/*/*.t') ) );

install_script glob('bin/*.pl');

auto_install;
WriteAll;
