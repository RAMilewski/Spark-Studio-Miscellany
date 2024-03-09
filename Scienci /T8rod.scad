include<BOSL2/std.scad>
include<BOSL2/threading.scad>

$fn = 72;

acme_threaded_rod(
            d=8, l=30, pitch=2, starts=4,
            internal=false, bevel=true,
            blunt_start=false, anchor=BOT);

cyl(d = 16, h = 10, rounding2 = 3);
