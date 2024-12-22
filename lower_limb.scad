include <modules/config.scad>;
use <modules/common.scad>;
use <modules/limb.scad>;

module lower_limb(length=10) {
    knee_joint_outer_radius =3;

    module edge() {
        translate([0, -length + 4, 2.5]) rotate([90, 0, 270]) linear_edge(5, 0.5, center=true);
        translate([2.5, -length + 4, 2.5]) rotate([0, 0, 270]) corner(0.5);
    }
    difference(){
        union() {
            rotate([0, 0, 180]) limb_base(length-4);
            translate([0, -length, 0]) scraped_sphere(3, 0.5);
            translate([0, -length+4+eps, 0]) rotate([90, 0, 0]) scraped_cylinder(2+eps, 1.5, 0.2);
            
        }
        edge();
        rotate([0, 90, 0]) edge();
        rotate([0, 180, 0]) edge();
        rotate([0, 270, 0]) edge();
    }
}

translate([5, 0, 0]) lower_limb(28);
translate([-5, 0, 0]) lower_limb(15);