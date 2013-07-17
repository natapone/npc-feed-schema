#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;

use Test::More tests => 6;
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

my $feed = $schema->resultset('feed')->find(2);
is($feed->name, "Tech reviews", "Feed:2 is Tech reviews");
is($feed->source->name, "T3", "Source of feed:2 is T3");

my $source = $schema->resultset('source')->find(2);
is($source->name, "Cnet", "Source:2 is Cnet");
ok($source->feeds->count() > 1, "Source:2 has many feeds" );

#use novus::thai::schema;
#use novus::thai::utils;
#use Data::Dumper;

#my $config = novus::thai::utils->get_config();
#my $schema = novus::thai::schema->connect(
#                                $config->{connect_info}[0], 
#                                $config->{connect_info}[1], 
#                                $config->{connect_info}[2], 
#                                $config->{connect_info}[3], 
#                                );

#my $source = $schema->resultset('Source')->find(1);
#is($source->name,"arip","Source id 1 is Arip");

#my $feeds = $source->feeds;
#my $feed = $feeds->find(1);
#is($feed->link,'http://www.arip.co.th/rss/rss_news_rich.xml',"Url of Arip is correct");

## get feeds and categories
#$feed = $schema->resultset('Feed')->find(60);

#my $categories = $feed->categories;

#my @cat_read;
#while (my $category = $categories->next) {
#    push(@cat_read, $category->id);
#    
#}

#my @cats_result = (2, 16);
#is_deeply(\@cat_read, \@cats_result, "Return categories of feed correctly");

#my $category = $schema->resultset('Category')->find(2);
#$feeds = $category->feeds;

#my @feed_read;
#while (my $feed = $feeds->next) {
#    push(@feed_read, $feed->id);
#}

#my @feed_result = (1, 9, 10, 26, 55, 60, 67, 72, 78, 128, 142, 101, 103, 111, 121);
#is_deeply(\@feed_read, \@feed_result, "Return feeds of category correctly");

#my $item = $schema->resultset('Item')->find(1);
#is ($item->feed->title, 'CITYLIFE', "get feed title from item correctly");
#is ($item->feed->source->name, 'daradaily', "get source name from item correctly");

### too much
##$feed = $schema->resultset('Feed')->find(2);
##print "feed id= ", $feed->id, ": ", $feed->title, "\n";
##my $feed_items = $feed->items;
##$feed_items = $feed_items->search({}, {rows => 5});
##while (my $feed_item = $feed_items->next) {
##    print $feed_item->id, ": ", $feed_item->title, "\n";
##}



