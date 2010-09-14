#!/usr/bin/env perl
use FindBin qw/$Bin/;
use Plack::Runner;
Plack::Runner->run("$Bin/../DayDayUp.pl");
