#!/usr/bin/perl

use strict;
use warnings;

opendir(DIR, ".");
my @pdks = grep(/^[0-9]+$/,readdir(DIR));
closedir(DIR);

print "Characterizing all Nodes\n";

sub Log {
    my ($code, $node, $mos) = @_;
    
    if ($code == 0) {
        print "[\e[1;32m ✔ \e[0m] $node nm $mos characterized.\n";
    } else {
        print "[\e[1;31m ✘ \e[0m] $node nm $mos characterization returned $code.\n"
    }
}

sub Char {
    my ($node, $mos) = @_;
    system "spectre -I./$node/pdk ./chr/$mos.scs > /dev/null";
    return $?;
}

foreach (@pdks) {
    my ($n, $p) = ("nmos", "pmos");
    
    my $nc = Char($_, $n);
    Log($nc, $_, $n);
   
    my $np = Char($_, $p);
    Log($np, $_, $p);
}
