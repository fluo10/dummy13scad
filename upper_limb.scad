include <modules/config.scad>;
use <modules/common.scad>;
use <modules/limb.scad>;

//color("red") {
//    translate([-10, 0, -2.5]) import("references/frame-upper-arm-2x.stl");
//    translate([10, 0, -2.5]) import("references/frame-thigh-2x.stl");
//}

module upper_limb(length=10) {
    knee_joint_outer_radius =3;
    
    
    module pivot_joint() {
        module pivot_joint_profile() {

            module base() {
                max_width=8;
                min_width=5;
                length=7.5;
                polygon([[-min_width/2, 0],[-max_width/2, max_width/2-min_width/2],  [-max_width/2, length], [max_width/2, length], [max_width/2, max_width/2-min_width/2], [min_width/2, 0]]);
            }
            module larger_hole() {
                difference() {
                    translate([0, 3.8, 0]) square([5.6, 2.6], center=true);
                    translate([0, 0.95, 0]) circle(2);
                }
            }
            module smaller_hole() {
                module rounded_corner(corner_radius=2) {
                    radius=10;
                    angle=71;
                    translate([corner_radius/tan(angle/2), corner_radius, 0]) hull(){
                        circle(corner_radius);
                        translate([radius, 0, 0]) circle(corner_radius);
                        translate([radius*cos(angle), radius*sin(angle), 0]) circle(corner_radius);
                    }
                }
                //translate([0, 6, 0]) circle(4.8);
                intersection() {
                    union() {           
                        center_radius=3;
                            translate([center_radius,-0.08, 0]) rotate([0, 0, 90]) rounded_corner(center_radius);
                            mirror([1, 0, 0]) translate([center_radius,-0.08, 0]) rotate([0, 0, 90]) rounded_corner(center_radius);
                        }
                        
               
                    union(){
                        translate([0, 0.95, 0]) circle(1.5);
                        translate([0, 0, 0]) square([5, 4], center=true);
                    }
                }         
            }
            difference(){
                base();
                larger_hole();
                smaller_hole();

                
                //translate([0, 5, 0]) circle(4);
                
            }
        }
        module top_right_bevel(){
            translate([4, 0, 2.5]) rotate([270, 270, 0]) linear_edge(10, 0.5);
            translate([2, -0.5, 2.5]) rotate([270, 270,-45]) linear_edge(10, 0.5);
        }
        difference(){
            linear_extrude(5, center=true) pivot_joint_profile();
            union() {
                translate([0, 6.5, 1.5]) cube(3, center=true);
                translate([0, 6.5, 0])rotate([90, 0, 0]) cylinder(h=3, r=1.6, center=true );
            }
            top_right_bevel();
            mirror([1, 0, 0]) top_right_bevel();
            mirror([0, 0, 1]) {
                top_right_bevel();
                mirror([1, 0, 0]) top_right_bevel();
            }
            
        }
    }

    difference(){
        union() {
            limb_base(length-7);
            translate([0, length-7.5, 0])pivot_joint();   
        }
    }
}

translate([10, 0, 0]) upper_limb(22);
translate([-10, 0, 0]) upper_limb(14);
upper_limb(12);