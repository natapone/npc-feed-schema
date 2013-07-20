package npc::feed::schema;

use 5.014002;
use base 'DBIx::Class::Schema';
use strict;
use warnings;

use npc::config;

our $VERSION = '0.01';

__PACKAGE__->load_classes;


sub connect_schema {
    my ($self) = @_;
    
    my $config = $self->collectorconfig;
    
    return npc::feed::schema->connect(
                                $config->{connect_info}[0], 
                                $config->{connect_info}[1], 
                                $config->{connect_info}[2], 
                                $config->{connect_info}[3], 
                            );
}

sub collectorconfig {
    my $config = npc::config->get_config('npc-feed-collector');
    return $config;
}


1;
__END__


=head1 AUTHOR

Natapone C, natapone@gmail.com

=cut
