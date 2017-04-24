#!/usr/bin/perl
#
# phdtex
#
# Copyright (c) 2014-2017, Andrew Kanner <andrew.kanner@gmail.com>.
# All rights reserved.
#
# SPDX-License-Identifier: MIT
#

# script for sorting .bbl files (Russian items first, English items
# second)

use File::Copy;

open (bblfile,"dissertation.bbl") or die "Error -- no file 'dissertation.bbl' founded\n";
open (bblfile_new, '>'."dissertation.bbl.test") or die "Error -- can`t create temporary file\n";

while (<bblfile>){
    $string .= $_;
}

# split bbl-file into bibitem blocks (first and last elements = bbl
# metainfo)
@array = split(/\n{2,}/, $string);
$blocks_count = @array;

@rus = ();
@eng = ();
@ruseng = ();

# search for "\selectlanguageifdefined{" and populate 2 arrays for
# Russian and English bibitems
for (my $i = 0; $i <= $blocks_count; $i++) {
    my @subarray = split(/\n/, $array[$i]);
    if ((index $array[$i],"\selectlanguageifdefined{russian}") != -1) {
        # for russian items (more then 3 authors), starting with english character in title
        if (substr($subarray[2], 0, 1) =~ /[a-zA-Z]/) {
            push (@ruseng, $array[$i]);
        }
        else {
            push (@rus, $array[$i]);
        }
    }
    elsif ((index $array[$i],"\selectlanguageifdefined{english}") != -1) {
        push (@eng, $array[$i]);
    }
}

print bblfile_new "$array[0]\r\n"; # preamble

#print bblfile_new join("\n", @rus);
foreach(@rus) {
    print bblfile_new "$_\r\n";
}

foreach(@ruseng) {
    print bblfile_new "$_\r\n";
}

foreach(@eng) {
    print bblfile_new "$_\r\n";
}

print bblfile_new "$array[$blocks_count - 1]\r\n"; # file ending

close(bblfile);
close(bblfile_new);

move('dissertation.bbl.test', "dissertation.bbl") or die "Failed to edit original file";

exit 0;
