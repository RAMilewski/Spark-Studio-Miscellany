include<BOSL2/std.scad>
include<BOSL2/threading.scad>

$fn = 72;

acme_threaded_rod(
            d=8, l=20, pitch=2, starts=4,
            internal=false, $slop = .2, bevel=true,
            blunt_start=false, anchor=BOT);
