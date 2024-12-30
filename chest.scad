include <modules/config.scad>;
use <modules/common.scad>;

color("red") {
    translate([-20, -6.5,0]) import("references/frame-chest.stl");
    translate([20, -6.5,0]) import("references/frame-chest-female.stl");
}

module chest(shoulder_width=12, neck_height=13.5, ) {
    shoulder_height=7.5;
    module right_shoulder() {
        module shoulder_edge() {
            translate([0.9, 0, 1.5]) rotate([90, 0, 0]) linear_edge(4, center=true);

        }
        translate([shoulder_width/2, 7.5, 0]) {
            scraped_sphere(3, 0.5);
            translate([0, -1.5, 0]) rotate([90, 0, 0]) scraped_cylinder(3, 1.5, 0.2);
            translate([-2, 3.25, 0]) rotate([0, 0, 45]) difference() {
                cube([1.8, 4, 3], center=true);
                shoulder_edge();
                mirror([1, 0, 0]) shoulder_edge();
                mirror([0, 0, 1]) {
                    shoulder_edge();
                    mirror([1, 0, 1]) shoulder_edge();
                }
            }
        }
    }
    module base() {
        module base_profile() {
            module mouth(radius, angle) {
                polygon([[0, 0], [-tan(angle/2) * (radius+eps), radius+eps], [tan(angle/2)* (radius+eps), radius+eps]]);
            }
                
            ball_joint_angle=120;
            ball_joint_outer_radius=4.5;
            difference(){
                union() {
                    translate([0, neck_height, 0]) circle(4.5);
                    translate([0, 2, 0]) square([shoulder_width+4, 3], center=true);
                    translate([0, -2, 0]) square(9, center=true);
                    translate([0, -6.5, 0]) circle(4.5);
                }
                translate([0, neck_height, 0]) {
                    circle(2.25);
                    mouth(ball_joint_outer_radius, angle=112.5);
                }
                translate([0, -6.5, 0]) {
                    circle(2.15);
                    rotate([0, 0, 180])mouth(ball_joint_outer_radius, angle=112.5);

                }
                square([3,3.2], center=true);
            }
        }
        linear_extrude(5, center=true) base_profile();
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
        translate([0, neck_height, 0]) sphere(2.9);
        translate([0, -6.5, 0]) sphere(2.85);
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

translate([-20, 0, 0]) chest();
translate([20, 0, 0]) chest(10, 14);
chest(8, 15);