#!/usr/bin/perl

use strict;
use warnings;

opendir(DIR, ".");
my @pdks = grep(/^[0-9]+$/,readdir(DIR));
closedir(DIR);

print "Running OP2 for all Nodes\n";

foreach (@pdks) {
    system "spectre =l ./src/op2-$_.log -I./$_/pdk ./$_/op2/input.scs";

    if ($? == 0) {
        print "[\e[1;32m ✔ \e[0m] No errors for $_ nm PTM devices.\n";
    } else {
        print "[\e[1;31m ✘ \e[0m] $_ nm PTM devices returned with $?.\n"
    }
}
