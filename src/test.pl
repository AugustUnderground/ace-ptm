#!/usr/bin/perl

use strict;
use warnings;

opendir(DIR, ".");
my @pdks = grep(/^[0-9]+$/,readdir(DIR));
closedir(DIR);


foreach my $i (1, 2, 3, 4, 6) {
    foreach (@pdks) {
        system "spectre =l ./src/op2-$_.log -I./$_/pdk ./$_/op$i/input.scs";
        if ($? == 0) {
            print "[\e[1;32m ✔ \e[0m] No errors for OP$i with $_ nm PTM devices.\n";
        } else {
            print "[\e[1;31m ✘ \e[0m] OP$i with $_ nm PTM devices returned with $?.\n"
        }
    }
}
