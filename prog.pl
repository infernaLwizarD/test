#!usr/bin/perl
use strict;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0');
my $response = $ua->get('http://bash.im');

if ($response->is_success) {
	my @content = split "\n", $response->content;
	my (@numbers, @quotes);
	foreach (@content) {
		if (/class="id"/) {
			/>#(.*)<\/a/;
			push @numbers, $1;
		} elsif (/class="text"/) {
			/>(.*)</;
			push @quotes, $1;
		}
	}

	print "[";
	foreach (0..$#numbers) {
		print "\n\t{\n\t\t\"number\" : $numbers[$_],\n\t\t\"text\" : \"" . $quotes[$_] . "\"\n\t}" . (($quotes[$#quotes] eq $quotes[$_]) ? "\n" : ",\n");
	}
	print "]";
} else {
	print "Error: " . $response->status_line . "\n";
}