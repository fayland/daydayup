#!perl

use strict;
use warnings;

use Mojo::Client;
use Mojo::Transaction;
use Test::More tests => 4;

# Prepare client and transaction
my $client = Mojo::Client->new;

# test /perl/
my $tx = Mojo::Transaction->new_get('/perl/');

# Process request
$client->process_local('DayDayUp', $tx);

# Test response
is($tx->res->code, 200);
is($tx->res->headers->content_type, 'text/html');
like($tx->res->content->file->slurp, qr/View Perl Source Code/i);

# test POST /perl
$tx = Mojo::Transaction->new_post('/perl/find_pod?module=CPAN');

# process
$client->process_local('DayDayUp', $tx);

# test response
like($tx->res->content->file->slurp, qr/Perl itself/i);