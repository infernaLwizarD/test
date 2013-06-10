#!usr/bin/perl
use strict;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0');
my $request = HTTP::Request->new(GET => 'http://bash.im');
$request->header('Accept' => 'text/html');
my $response = $ua->request($request);

my @content = split "\n", $response->content;
my @numbers = map />#(.*)<\/a/, (grep /class="id"/, @content);
my @quotes = map />(.*)</, (grep /class="text"/, @content);

open FILE, ">file.txt";
print FILE "[";
foreach (0..$#numbers) {
	print FILE "\n\t{\n\t\t\"number\" : $numbers[$_],\n\t\t\"text\" : \"" . $quotes[$_] . "\"\n\t}" . (($quotes[$#quotes] eq $quotes[$_]) ? "\n" : ",\n");
}
print FILE "]";