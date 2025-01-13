include <modules/config.scad>;
use <modules/common.scad>;
use <modules/ball_joint.scad>;

module limb_root(length=5){
    module ball_joint(){
        module top_right_edge(){
            translate([4.5, 0, 2.5]) rotate([90, 0, 0]) linear_edge(4, bevel_size=0.5, center=false);
            
        }
        difference() {
            union() {
                ball_joint_stag_socket(outer_radius=4.5, ball_radius=2.9, inner_radius=2.2, angle=112.5, thickness=5);
                linear_extrude(5, center=true) {
                    difference(){
                        translate([0, -2, 0]) square([9, 4], center=true);
                        circle(3);
                        polygon([[4.5, -4], [4.5, -2.8], [3.7, -2.8], [2.5, -4]]);              
                        polygon([[-4.5, -4], [-4.5, -2.8], [-3.7, -2.8], [-2.5, -4]]); 

                    }
                }
            }
            top_right_edge();
            mirror([1, 0, 0]) top_right_edge();
            mirror([0, 0, 1]) {
                top_right_edge();
                mirror([1, 0, 0]) top_right_edge();
            }
            
        }
    }
    module hinge_joint() {
        translate([0, -length-eps, 0]) rotate([90, 0, 0]) scraped_cylinder(h=2.6+eps*2, r=1.5, scraped_thickness=0.2, center=false);
        translate([0, -length-2.6, 0]) rotate([90, 0, 0]) scraped_cylinder(h=2.3, r=3, scraped_thickness=0.5, center=false);
    }
    module base() {
        base_length=length-4;
        translate([0, -base_length/2+eps-4, 0]) rotate([90, 0, 0]) beveled_cube([5, 5, base_length + eps], center=true, bevel_size=1, bevel_top=false, bevel_side=true, bevel_bottom=false);
    }
    union() {
        ball_joint();
        hinge_joint();
        base();
    }
}
    

color("red") translate([0, 0, -2.5]) import("references/frame-hip-and-shoulder-4x.stl");
limb_root();
translate([10, 0, 0]) limb_root(length=10);