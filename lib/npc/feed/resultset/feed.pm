package npc::feed::resultset::feed;
use strict;
use warnings;
use Data::Dumper;

use base qw(DBIx::Class::ResultSet);

sub fetchnext {
    my $self = shift;
    
    # fetch condition: active, expired (fetchnext < timestamp)
    my $feed = $self->search(
        {
            'active'    => 1,
            'fetchnext' => { '<' => time },
        }, {
            order_by => 'lasttimestamp',
        }
    )->first();

    if ( $feed ) {
#        print 'Next queued Feed has ID #' . $feed->id()."\n";
        return $feed;
    } else {
        return 0;
    }
}




1;

=head1 AUTHOR

Natapone C, natapone@gmail.com

=cut
