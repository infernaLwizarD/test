#!usr/bin/perl
use strict;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0');
my $request = HTTP::Request->new(GET => 'http://bash.im');
$request->header('Accept' => 'text/html');
my $response = $ua->request($request);

my @content = split "\n", $response->content;
my @quotes = map />(.*)</, (grep /class="text"/, @content);
open FILE, ">file.txt";
print FILE "[";
foreach (@quotes) {
	print FILE "\n\t{\n\t\t\"text\" : \"" . $_ . "\"\n\t}" . (($quotes[$#quotes] eq $_) ? "\n" : ",\n");
}
print FILE "]";