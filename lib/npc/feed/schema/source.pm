package npc::feed::schema::source;
use base 'DBIx::Class';
use strict;
use warnings;

__PACKAGE__->load_components(qw/ Core/);
__PACKAGE__->table('source');


__PACKAGE__->add_columns(
    'id' => {
  'data_type' => 'integer',
  'is_auto_increment' => 0,
  'default_value' => 'nextval(\'source_id_seq\'::regclass)',
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
    'url' => {
  'data_type' => 'character varying(255)',
  'is_auto_increment' => 0,
  'default_value' => undef,
  'is_foreign_key' => 0,
  'name' => 'url',
  'is_nullable' => 1,
  'size' => 259
},
    'rank' => {
  'data_type' => 'smallint',
  'is_auto_increment' => 0,
  'default_value' => '0',
  'is_foreign_key' => 0,
  'name' => 'rank',
  'is_nullable' => 1,
  'size' => '0'
},
);

__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many('feeds' => 'npc::feed::schema::feed', { "foreign.sourceid" => "self.id" }, {join_type => 'left'});

1;
__END__
