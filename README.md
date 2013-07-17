npc-feed-schema
===============

Schema for feed system

# DBIX Schema import/export
http://search.cpan.org/~elliott/DBIx-Class-0.06002/lib/DBIx/Class/Manual/Cookbook.pod#Schema_import/export

# EXTRACT SQL SCHEMAS DIRECTLY FROM DATABASE
http://search.cpan.org/~ribasushi/SQL-Translator-0.11006/lib/SQL/Translator/Manual.pod#EXTRACT_SQL_SCHEMAS_DIRECTLY_FROM_DATABASE

sqlt --from DBI \
--to DBIx::Class::File \
--dsn "dbi:Pg:database=npc_feed;host=localhost;" --db-user devel --db-password devel \
--prefix "npc::feed::schema" > npc-feed-schema.pm




