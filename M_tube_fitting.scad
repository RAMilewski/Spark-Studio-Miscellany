//  Spark Studio
//  Tube fittings for lighted M sign from 28mm tubes.
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>
$fn=72;

eps = 0.1;
dia = 29;           //  Tube id
neck = 20;          //  Length of neck
wall = 1;           //  Insert wall thickness
tubewall = 1.35;    //  Tube wall thickness
hole = 4;           // Mounting hole dia.
dia2 = dia + 2 * tubewall;    //  Tube od  
r2 = dia2/2;                  //  Tube radius
id = dia - wall * 2;          //  Insert id
base = wall + tubewall;       //  Height of base  
rgn = [ circle(d =dia2), circle(d = dia - 2 * wall) ];
tab = r2+neck/2;


joint90();



/*######################################################/*

    MODULES

/*######################################################*/

module joint90() {
    tfm = [
        down(neck/2),
        for (a=[0:5:90]) yrot(a, cp=[r2+eps,0,0]),
        move([neck/2 + r2,0,r2]) * yrot(90),
    ];
    sweep(rgn, tfm, closed=false, caps=true);


    tube(od = dia, wall = wall, h = neck, anchor = TOP);
    up(r2) right(r2) yrot(90) tube(od = dia, wall = wall, h = neck, anchor = BOT);

    fwd(r2-0.1) up(r2) {   // Mounting plate
        difference() {
            #cuboid([tab,base,tab], rounding = hole * 2.5, edges = "Y", anchor = FWD+LEFT+UP);
            right(neck) down(neck) fwd(eps/2)
                ycyl(d = hole, h = base+eps, anchor = FWD);
        }
    }
}

module joint45() {
    tube(od = dia, id = id, l = neck, anchor = BOT);
    up(neck/2) tube(od = dia2, id = id, l = neck/2, anchor = BOT);
    up(neck) {
        rgn = [ circle(d =dia2), circle(d = dia - 2 * wall) ];
        tfm = [

            for (a=[0:5:135]) yrot(a, cp=[r2+eps,0,0]),
            
        ];
        sweep(rgn, tfm, closed=false, caps=true) {
            attach(RIGHT+DOWN)
                union() {
                    tube(od = dia, id = id, l = neck, anchor = BOT);
                    up(neck/2) tube(od = dia2, id = id, l = neck/2, anchor = TOP);
                }
        }
    }        
}