#!/usr/bin/env perl
use FindBin qw/$Bin/;
use Plack::Handler::FCGI;

my $app = do("$Bin/../DayDayUp.pl");
my $server = Plack::Handler::FCGI->new(nproc  => 5, detach => 1);
$server->run($app);
