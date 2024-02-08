include <BOSL2/std.scad>

wall = 6;
board=[83,135.8,17.9];
fudge=[20,20,1];
id = board + fudge;
od = id + [2 * wall,2 * wall,undef];
window = [board.x-5, board.y-5, 3];
corner = 6;
d_cable = 8;
cable_offset = ([0,board.y/2-24,4]);

diff() {
    rect_tube(isize = [window.x, window.y], h = window.z, size = [od.x, od.y], rounding = corner){
        attach(TOP) color("skyblue") rect_tube(isize = [id.x, id.y], h=id.z, size = [od.x, od.y], rounding = corner);
        attach(TOP) up(4) move(cable_offset) tag("remove") xcyl(d = d_cable, l = od.x+1);
    // attach(TOP) left(od.x/2) move(cable_offset)  yrot(90) ruler(anchor = CENTER);
    }

}

