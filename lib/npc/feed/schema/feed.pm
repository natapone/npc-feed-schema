package npc::feed::schema::feed;
use base 'DBIx::Class';
use strict;
use warnings;
use WWW::Curl::Simple;
use Try::Tiny;
use Data::Dumper;
use npc::config;

use npc::feed::resultset::feed;

__PACKAGE__->load_components(qw/ Core/);
__PACKAGE__->table('feed');
__PACKAGE__->resultset_class("npc::feed::resultset::feed");

__PACKAGE__->add_columns(
    'id' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => 'nextval(\'feed_id_seq\'::regclass)',
  'is_foreign_key' => 0,
  'name' => 'id',
  'is_nullable' => 0,
  'size' => '0'
},
    'name' => {
  'data_type' => 'character varying(255)',
  'is_auto_increment' => 0,
  'default_value' => undef,
  'is_foreign_key' => 0,
  'name' => 'name',
  'is_nullable' => 1,
  'size' => 259
},
    'categoryid' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => '1',
  'is_foreign_key' => 0,
  'name' => 'categoryid',
  'is_nullable' => 1,
  'size' => '0'
},
    'typeid' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => '1',
  'is_foreign_key' => 0,
  'name' => 'typeid',
  'is_nullable' => 1,
  'size' => '0'
},
    'sourceid' => {
  'data_type' => 'smallint',
  'is_auto_increment' => 0,
  'default_value' => '0',
  'is_foreign_key' => 0,
  'name' => 'sourceid',
  'is_nullable' => 1,
  'size' => '0'
},
    'url' => {
  'data_type' => 'character varying(1024)',
  'is_auto_increment' => 0,
  'default_value' => undef,
  'is_foreign_key' => 0,
  'name' => 'url',
  'is_nullable' => 1,
  'size' => 1028
},
    'description' => {
  'data_type' => 'character varying(255)',
  'is_auto_increment' => 0,
  'default_value' => undef,
  'is_foreign_key' => 0,
  'name' => 'description',
  'is_nullable' => 1,
  'size' => 259
},
    'lasttimestamp' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => '0',
  'is_foreign_key' => 0,
  'name' => 'lasttimestamp',
  'is_nullable' => 1,
  'size' => '0'
},
    'fetchinterval' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => '3600',
  'is_foreign_key' => 0,
  'name' => 'fetchinterval',
  'is_nullable' => 1,
  'size' => '0'
},
    'fetchnext' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => '0',
  'is_foreign_key' => 0,
  'name' => 'fetchnext',
  'is_nullable' => 1,
  'size' => '0'
},
    'active' => {
  'data_type' => 'smallint',
  'is_auto_increment' => 0,
  'default_value' => '1',
  'is_foreign_key' => 0,
  'name' => 'active',
  'is_nullable' => 1,
  'size' => '0'
},
    'scrapetype' => {
  'data_type' => 'smallint',
  'is_auto_increment' => 0,
  'default_value' => '0',
  'is_foreign_key' => 0,
  'name' => 'scrapetype',
  'is_nullable' => 1,
  'size' => '0'
},
);

__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to('source' => 'npc::feed::schema::source', { "foreign.id" => "self.sourceid" });

sub collectorconfig {
    my $config = npc::config->get_config('npc-feed-collector');
    return $config;
}

sub fetch {
    my ($self, $path) = @_;
    
    if(!defined($path)) {
        my $config = $self->collectorconfig;
        $path = $config->{'feed_root'}.'/new';
    }
#    print Dumper($self->_get_link($self->link)) ;
    
    # prevent colliding, put it to back of the list
    $self->update({ 
            lasttimestamp   => time,
    });
    
    my $feed_result = {};
    my $feed_url = $self->url;
    do {
        $feed_result = $self->_get_link($feed_url);
        $feed_url = $feed_result->{'location'} if $feed_result->{'status'} == -1;
        
    } until ($feed_result->{'status'} == 1 or $feed_result->{'status'} == 0 ); 
    
    
    if ($feed_result->{'status'} == 1) {
        # print to file
        my $filename = "T".time."F".$self->id.".xml";
        if ( $filename ne 'testmode') {
            open (XMLFILE, ">$path/$filename");
            print XMLFILE $feed_result->{'content'};
            close (XMLFILE); 
            
            # update next fetch time
            my $timestamp = time;
            my $intv = $self->fetchinterval;
            $self->update({ 
                    fetchnext   => $timestamp + $intv,
            });
            
        }
        return $filename;
    } else {
        return $feed_result->{'error_status'}
    }
    
}

sub _get_link {
    my ($self, $url) = @_;
    
    my $curl = WWW::Curl::Simple->new(timeout=>5);
    my $res;
    my $result = {};
    
    try {
        $res = $curl->get($url);
    } catch {
        warn "Death link: ".$url; # not $@
        $result->{'status'}  = -2;
    };
    
    if ($res->is_redirect) {
        $result->{'location'} = $res->header('location');
        $result->{'status'}  = -1;
    } elsif ($res->is_success) {
        $result->{'content'} = $res->content;
        $result->{'status'}  = 1;
    } else {
        $result->{'status'}  = 0;
        $result->{'error_status'}  = $res->status_line;
    }
    
    return $result;
}

1;
__END__

=head1 AUTHOR

Natapone C, natapone@gmail.com

=cut
