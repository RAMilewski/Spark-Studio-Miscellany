// Henry's Second Project

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn = 16;
eps = 0.1;

theta = 180;                    // Angle of rotation
bumper = ([8 * INCH, 4, 15]);   // [radius of curvature, wall size, z-height] dimensions of bumper
foot = ([30, 15, 8]);           // [x, y, z] dimensions of foot
foot_screws = 1;                // number of screw holes in foot
corner = 5;                     // radius of foot corner
screw_spec = "#6-0,1/2";        // screw size
counterbore = false;            // false = countersink, true = counterbore
fudge = 2.2;                      // angular fudge factor to position the 2 outside feet

bumper();
foot();

module bumper() {
    diff() {
        zrot(-theta/2) pie_slice(r = bumper.x, h = bumper.z, ang = theta, anchor = BOT, $fn = 144)
        down(eps/2) zrot(1) attach(BOT) tag("remove") pie_slice(r = bumper.x - bumper.y, h = bumper.z + eps, ang = theta + 2, anchor = TOP, $fn = 144);
        //round the ends of the bumper
        up(bumper.z)
            zrot_copies([-theta/2, theta/2], r = bumper.x - bumper.y - 0.5)
                tag("remove") rounding_angled_edge_mask(l=bumper.y + 1, r=bumper.z/2, ang = 90, orient=RIGHT, anchor=BOTTOM);    
    }
}

module foot() {
    head  = counterbore == true ? "socket" : "flat";
    cbore = counterbore == true ? 4 : 0;
    footPos = foot_screws == 2 ? bumper.x - bumper.y/2 : bumper.x - bumper.y/2 - foot.x/4;    // position of foot is depentant on number of screws
    zrot_copies([-theta/2 + fudge, 0, theta/2 - fudge], r = footPos) 
        if (foot_screws == 2) {
            diff() {
                cuboid(foot, rounding = corner, edges = "Z", anchor = BOT)
                    xcopies(n = 2, spacing = foot.x/2) 
                        tag("remove") attach(TOP) screw_hole(screw_spec, tolerance = "loose", head=head, counterbore=cbore, anchor=TOP);
            }    
        } else {
           diff() {
                cuboid([foot.x/2, foot.y, foot.z], rounding = corner, edges = "Z", except = RIGHT, anchor = BOT)
                tag("remove") attach(TOP) screw_hole(screw_spec, tolerance = "loose", head=head, counterbore=cbore, anchor=TOP);
           }
        }
}
