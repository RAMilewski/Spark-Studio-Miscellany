include<BOSL2/std.scad>

$fn = 72;;

thickness = 2;
lever = 12;
leverH = 6;

handleDia = leverH * 2;
handle = 24;


diff(){
cyl(d = handleDia, l = handle, rounding2 = handleDia/2) 
    attach(BOT) tag("remove") cube([leverH, thickness, lever], anchor = TOP);
}
