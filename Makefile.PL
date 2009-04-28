use inc::Module::Install;

name            ('DayDayUp');
author          ('Fayland Lam<fayland@gmail.com>');
abstract        ('DayDayUp - good good study, day day up');
license         ('perl');
version_from    ('lib/DayDayUp.pm');

repository 'http://github.com/fayland/daydayup/tree/master';

requires 'Mojo'     => '0.9002';
requires 'Moose'    => '0.75';
requires 'Template' => '2.20';
requires 'Template::Plugin::FillInForm';
requires 'MojoX::Renderer::TT' => '0.20';
requires 'MojoX::Fixup::XHTML';
requires 'KiokuDB'  => '0.27';
requires 'KiokuDB::Backend::DBI';
requires 'DBD::SQLite' => '1.25';
requires 'MooseX::Declare' => '0.10';
requires 'MooseX::Types';

tests ( join ' ', ( glob('t/*.t'), glob('t/*/*.t') ) );

install_script glob('bin/*.pl');

auto_install;
WriteAll;
