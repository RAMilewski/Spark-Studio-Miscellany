include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn = 72;
$slop = 0.05;           //adjust this value for printer over/under extrusion.

top = true;           // true print top half , false prints bottom half.

wall = 10;
floor = 3;
board=[83,135.8,17.9];
fudge=[3,3,0];          //adjust free space around the board
id = board + fudge;
od = id + [2 * wall,2 * wall];
plate = [od.x, od.y, floor];
window = [board.x-wall, board.y-wall, board.z];
corner = 6;
d_cable = 8;
cable_offset = ([0,board.y/2-24,d_cable/2]);

screw = "M3";
screwhead = "socket";
pattern = [3,3];        //screw pattern [columns, rows]


shell(top);

module shell (isTop) {
    diff() {
        rect_tube(isize = [id.x, id.y], wall = wall, h = board.z/2, rounding = corner, anchor = CENTER) {
            
            attach(BOT) plate();
            
            tag("remove") move(cable_offset) xcyl(d = d_cable, l = board.x * 2, anchor = CENTER);
            
            tag("remove") down(floor/2) grid_copies(n = [3,4], size = [od.x - wall, od.y - wall]) 
                if (isTop == true) {
                zflip() screw_hole(screw, head = screwhead, counterbore = true, l = board.z/2, $fn=32);
                } else {
                screw_hole(screw, l = board.z/2 + floor, $fn=32)
                    position(BOT) nut_trap_inline(5);
                }
        }
    }
}


module plate() {
    tag_scope()
    attachable(keep_color = true, expose_tags = false) {
        diff() {
            color("springgreen") cuboid(plate, rounding = corner, edges = "Z", anchor = BOT);
            tag("remove") down(0.1) cuboid(window, rounding = corner, edges = "Z", anchor = BOT);
            }
        children();
    }
}

module dummy_BMS() {
    color("silver") cuboid(board, rounding =2, edges = "Z");
        move(cable_offset) {
            color("dodgerblue") xcyl(d = d_cable, l = board.x, anchor = LEFT);
            color("Tomato") xcyl(d = d_cable, l = board.x, anchor = RIGHT);
        }

}


