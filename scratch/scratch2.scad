include<BOSL2/std.scad>

$fn = 72;

ang = 120;
r = 8 * INCH;
depth = 50;
mount = [35, 20, depth/2];

echo(r);


difference() {
    pie_slice(ang = ang, d = r, h = depth, spin=-60);
    cyl(d = 190, h = depth, anchor = BOT);
}

mount();

module mount() {
    rot_copies(delta = [r,0,0], v = UP, rots = [[0,0,-30], [0,0,0], [0,0,1]])
        diff(){
            cuboid(mount, rounding = 5, except= BOT, anchor = BOT);
            xcopies(n = 2, spacing = mount.x/2) tag("remove") cyl(d = 6, h = mount.z, rounding2 = -3, anchor = BOT);
        }
}