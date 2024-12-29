include <modules/config.scad>;
use <modules/common.scad>;

color("red") {
    translate([-20, -6.5,0]) import("references/frame-chest.stl");
    translate([20, -6.5,0]) import("references/frame-chest-female.stl");
}

module chest(shoulder_width) {
    module right_shoulder() {
        translate([shoulder_width/2, 7.5, 0]) {
            scraped_sphere(3, 0.5);
            translate([0, -1.5, 0]) rotate([90, 0, 0]) scraped_cylinder(3, 1.5, 0.2);
            translate([-2, 3.25, 0]) rotate([0, 0, 45])cube([1.8, 4, 3], center=true);
        }
    }
    module base() {
    }
    
    module top_right_bevel() {
    }
    module top_bevel() {
    }
    
    difference() {
        union(){
            base();
            right_shoulder();
            mirror([1, 0, 0]) right_shoulder();
            
        }
        top_right_bevel();
        mirror([1, 0, 0]) top_right_bevel();
        top_bevel();
        mirror([0, 0, 1]) {
            top_right_bevel();
            mirror([1, 0, 0]) top_right_bevel();
            top_bevel();
        }
    }
    
}

translate([-20, 0, 0]) chest(12);
translate([20, 0, 0]) chest(10);
chest(8);