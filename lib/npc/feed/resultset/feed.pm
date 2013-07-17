package npc::feed::resultset::feed;
use strict;
use warnings;
use Data::Dumper;

use base qw(DBIx::Class::ResultSet);

sub fetchnext {
    my $self = shift;
    
    
    print "-------------> Feed resultset\n";
    
#    my $feed = $self->search(
#        {
#            'active'        => 1,
#            'opoint'        => 0,
#            'opointsection' => 0,
#        },

#        # To get the same sort order of NULLs in
#        # both SQLite and PostgreSQL. NULLs should
#        # sort first.
#        {
#            order_by => 'lastpolled is not null, lastpolled',
#        },
#    )->first();

#    if ( $feed ) {
#        get_logger()->debug( 'Next queued Feed has ID #' . $feed->id() );
#    }

#    return $feed;
}




1;

=head1 AUTHOR

Natapone C, natapone@gmail.com

=cut
