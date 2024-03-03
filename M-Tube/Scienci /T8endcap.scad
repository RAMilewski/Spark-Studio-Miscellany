include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fn = 72;

difference() {
    knob();
    logo();
}

module logo() {
    rot_copies(n=4, delta = [0,2,0])
    text3d("M", size = 5, font = "Avenir Next", h = 1, anchor = BOT);
}

module knob() {
    difference() {
    cyl(d1 = 30, d2 = 10, rounding1 = 3, teardrop = true,  h=20, anchor=BOT);
    up(5) acme_threaded_rod(
        d=8, l=20, pitch=2, starts=4,
        internal=true, bevel=true,
        blunt_start=false, anchor=BOT
    );
    }
}
