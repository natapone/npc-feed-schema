#!/usr/bin/perl -w
use strict;
use warnings;

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

print "Read feeds\n";
my $f_count = 0;
while($fetchfeed) {
    my $fetch_status = $fetchfeed->fetch();
    print "ID:", $fetchfeed->id, ' ', $fetchfeed->url;
    print " target= ", $fetch_status, "\n";
    $f_count++;
    
    $fetchfeed = $feeds->fetchnext();
}

print "Done! fetch $f_count feeds \n";





