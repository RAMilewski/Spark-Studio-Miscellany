include <BOSL2/std.scad>

board=[83,135.8,17.9];
fudge=[1,1,1];
id = board + fudge;
wall = 4;

rect_tube(isize = [id.x, id.y], h=id.z, wall = wall);

