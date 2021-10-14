#!/usr/bin/perl

use strict;
use warnings;
use experimental 'switch';

use Getopt::Long qw(GetOptions);
use Scalar::Util qw(looks_like_number);

my $usage = "Usage:\t$0 [--nmos | --pmos] [--tech NODE]\n";

# Read available technology nodes
opendir(DIR, ".");
my @all_pdks = grep(/^[0-9]+$/,readdir(DIR));
closedir(DIR);

my @tech;   # Technology Node
my $nmos;   # NMOS Device
my $pmos;   # PMOS Device
my @pdks;   # The nodes in this list will be characterized.

$|++;

# Just Loggin
sub Log {
    my ($code, $node, $mos) = @_;
    
    if ($code == 0) {
        print "[\e[1;32m ✔ \e[0m] $node nm $mos characterized.\n";
    } else {
        print "[\e[1;31m ✘ \e[0m] $node nm $mos characterization returned $code.\n"
    }
}

# Characterize a primitive device 
# Char(node, device) => exit_code
sub Char {
    my ($node, $mos) = @_;
    my $raw_file = "./chr/$node-$mos.raw";
    my $net_list = "./chr/$mos.scs";
    my $flags    = "-log -format nutbin";
    system "spectre $flags -raw $raw_file -I./$node/pdk $net_list > /dev/null";
    return $?;
}

# Get command line arguments
GetOptions( 'tech|t=s' => \@tech
          , 'nmos|n'   => \$nmos
          , 'pmos|p'   => \$pmos
          ) or die $usage;

# Characterize either ALL, 1 or NONE.
given(@tech) {
    when (!@tech) {  # If no NODE is specified do all.
        @pdks = @all_pdks;
    }
    default {        # Otherwise go through the desired NODEs
        foreach (@tech) {
            given ($_) {
                when(\&looks_like_number) { # If it looks like a number pad it
                    $_ = sprintf("%03d", $_);
                    continue;
                }
                when(@all_pdks) {           # If a directory of that name exists
                    @pdks = (@pdks, $_);    # Append the technology node
                }
                default {                   # Throw error otherwise
                    die "@_ is not a valid NODE.\nHas to be ∈ [@all_pdks].\n";
                }
            }
        }
        print "defined -> @pdks \n";
    }
}

# If no device type is given, enable both.
unless($nmos || $pmos) { ($nmos, $pmos) = (1,1); }

foreach(@pdks) {
    my ($n, $p) = ("nmos", "pmos");
    
    if($nmos){
        my $nc = Char($_, $n);
        Log($nc, $_, $n);
    }

    if($pmos){
        my $np = Char($_, $p);
        Log($np, $_, $p);
    }
}

exit 0;
