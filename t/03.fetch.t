#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;

use Test::More tests => 4;
BEGIN { use_ok('npc::feed::schema') };
BEGIN { use_ok('npc::config') };

use npc::feed::schema;
use npc::config;
use Data::Dumper;

my $config = npc::config->get_config('npc-feed-collector');

my $schema = npc::feed::schema->connect(
                                $config->{connect_info}[0], 
                                $config->{connect_info}[1], 
                                $config->{connect_info}[2], 
                                $config->{connect_info}[3], 
                                );

my $feeds = $schema->resultset('feed');
my $fetchfeed = $feeds->fetchnext();

isa_ok($fetchfeed, "npc::feed::schema::feed");
ok ($fetchfeed->id , "return only 1 feed correctly" );

