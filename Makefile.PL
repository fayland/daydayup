use inc::Module::Install;

name            ('DayDayUp');
author          ('Fayland Lam<fayland@gmail.com>');
abstract        ('DayDayUp - good good study, day day up');
license         ('perl');
version_from    ('lib/DayDayUp.pm');

requires 'Mojo'     => '0.9';
requires 'Moose'    => '0.57';
requires 'Template' => '2.20';
requires 'Template::Plugin::FillInForm';
requires 'MojoX::Renderer::TT' => '0.20';
requires 'MojoX::Fixup::XHTML';
requires 'File::Spec';
requires 'DBI';
requires 'DBD::SQLite';
requires 'YAML';
requires 'File::Slurp';
requires 'LWP::Simple';

tests ( join ' ', ( glob('t/*.t'), glob('t/*/*.t') ) );

install_script glob('bin/*.pl');

auto_install;
WriteAll;
