include <modules/config.scad>;
use <modules/common.scad>;
use <modules/ball_joint.scad>;

//color("red") {
//    translate([-20, -6.5,0]) import("references/frame-chest.stl");
//    translate([20, -6.5,0]) import("references/frame-chest-female.stl");
//}

module chest(shoulder_width=12, neck_height=13.5, ) {
    shoulder_height=7.5;
    stomach_joint_angle = 112.5;
    stomach_joint_outer_radius = 4.5;
    stomach_joint_inner_radius = 3;
    neck_joint_angle = 112.5;
    neck_joint_outer_radius = 4.5;
    neck_joint_inner_radius = 3;
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
            module side_slit() {
                side_slit_radius=0.2;
                side_slit_depth=3.5;
                translate([3.2, -3.2, 0]) {
                    circle(side_slit_radius);
                    translate([side_slit_depth/2, 0, 0]) square([side_slit_depth, side_slit_radius*2], center=true);
                }
            }
                
            ball_joint_angle=120;
            ball_joint_outer_radius=4.5;
            difference(){
                union() {
                    translate([0, 2, 0]) square([shoulder_width+4, 3], center=true);
                    translate([0, -2, 0]) square(9, center=true);
                    translate([0, -6.5, 0]) circle(4.5);
                }
                translate([0, -6.5, 0]) {
                    circle(2.15);
                    rotate([0, 0, 180])mouth(ball_joint_outer_radius, angle=112.5);

                }
                square([3,3.2], center=true);
                side_slit();
                mirror([1, 0, 0]) side_slit();
            }
        }
        linear_extrude(5, center=true) base_profile();
    }
    
    module top_right_bevel() {
        translate([1.5, 1.6, 2.5]) rotate([0, 0, 180]) concaved_corner(0.5);
        translate([1.5, -1.6, 2.5]) rotate([0, 0, 90]) concaved_corner(0.5);
        translate([1.5, 0, 2.5]) rotate([90, 0, 180]) linear_edge(length=3.2, bevel_size=0.5, center=true);
        translate([4.5, 0.5, 2.5]) rotate([0, 0, 270]) concaved_corner(0.5);
        translate([4.5, 0.5, 2.5]) rotate([0, 270, 180]) linear_edge(length=shoulder_width/2, bevel_size=0.5, center=false);
        translate([4.5, 0.5, 2.5]) rotate([90, 0, 0]) linear_edge(length=7, bevel_size=0.5, center=false);
        translate([shoulder_width/2+2, 2, 2.5]) rotate([90, 0, 0]) linear_edge(length=3.2, bevel_size=0.5, center=true);
        translate([shoulder_width/2+2, 3.5, 2.5]) {
            corner(bevel_size=0.5);
            rotate([180, 0, 90]) linear_edge(length=2.5, bevel_size=0.5, center=false);
        }
        translate([shoulder_width/2+2, 0.5, 2.5]) {
            rotate([0, 0, 270]) corner(bevel_size=0.5);
            rotate([180, 0, 0]) linear_edge(length=2.5, bevel_size=0.5, center=false);
        }
        translate([0, -6.5, 2.5]) {
            rotate([90, 0, -neck_joint_angle/2]) linear_edge(length=neck_joint_outer_radius, bevel_size=0.5, center=false); 
            translate([neck_joint_outer_radius*sin(neck_joint_angle/2),- neck_joint_outer_radius*cos(neck_joint_angle/2), 0]) {
                rotate([180, 0, 270 + neck_joint_angle/2]) linear_edge(length=2.5, bevel_size=0.5, center=false);
                rotate([0, 0,  180+ neck_joint_angle/2]) corner(bevel_size=0.5);       
            }
        }

    }
    module top_bevel() {
        translate([0, 1.6, 2.5]) rotate([90, 0, 270]) linear_edge(length=3, bevel_size=0.5, center=true);
        translate([0, -1.6, 2.5]) rotate([90, 0, 90]) linear_edge(length=3, bevel_size=0.5, center=true);
        translate([0, 3.5, 2.5]) rotate([90, 0, 90]) linear_edge(length=shoulder_width+4, bevel_size=0.5, center=true);
        translate([0, -6.5, 2.5]) {
            rotate([0, 0, 180]) rotate_edge(radius=4.5, bevel_size=0.5, angle=180);
            rotate_edge(radius=2, bevel_size=0.5, concave=true);
        }
    }
    
    difference() {
        union(){
            base();
            right_shoulder();
            mirror([1, 0, 0]) right_shoulder();
            translate([0, neck_height, 0]) ball_joint_stag_socket(outer_radius=4.5, ball_radius=2.85, inner_radius=2.2, angle=112.5, thickness=5);
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