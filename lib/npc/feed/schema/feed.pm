package npc::feed::schema::feed;
use base 'DBIx::Class';
use strict;
use warnings;

__PACKAGE__->load_components(qw/ Core/);
__PACKAGE__->table('feed');


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

1;
__END__
