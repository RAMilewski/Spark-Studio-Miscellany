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
        cyl(d1 = 25, d2 = 15, rounding1 = 3, teardrop = false,  h=15, anchor=BOT);
        up(3) acme_threaded_rod(
            d=8, l=20, pitch=2, starts=4,
            internal=true, $slop = .37, bevel=false,
            blunt_start=false, anchor=BOT
        );
    }
}
