#!usr/bin/perl
use strict;
#use Data::Dumper;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0');
my $response = $ua->get('http://bash.im');

my @content = split "\n", $response->content;
my @quotes = map />(.*)</, (grep /class="text"/, @content);

if ($response->is_success) {
	print "[";
	foreach (@quotes) {
		print "\n\t{\n\t\t\"text\" : \"" . $_ . "\"\n\t}" . (($quotes[$#quotes] eq $_) ? "\n" : ",\n");
	}
	print "]";
} else {
	print "Error: " . $response->status_line . "\n";
}