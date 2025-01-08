include <config.scad>;
use <common.scad>;

module ball_joint_stag_socket(outer_radius=4.5, ball_radius=2.85, inner_radius=2.2, angle=112.5, thickness=5){
    module missing_piece_of_circle(radius, angle) {
        polygon([[0, 0], [-tan(angle/2) * (radius+eps), radius+eps], [tan(angle/2)* (radius+eps), radius+eps]]);
    }
    module top_bevel() {
        translate([0, 0, thickness/2]) {
            rotate_edge(radius=4.5, bevel_size=0.5);
        rotate_edge(radius=2, bevel_size=0.5, concave=true);
        }
    }
    module right_bevel() {
        translate([0, 0, thickness/2]) rotate([90, 0, 180-angle/2]) linear_edge(length=outer_radius, bevel_size=0.5, center=false);
        translate([0, 0, -thickness/2]) rotate([270, 0, angle/2]) linear_edge(length=outer_radius, bevel_size=0.5, center=false);
       translate([outer_radius*sin(angle/2), outer_radius*cos(angle/2),0])  rotate([180, 0, 180-angle/2]) linear_edge(length=thickness, bevel_size=0.5, center=true);
        translate([outer_radius*sin(angle/2), outer_radius*cos(angle/2), thickness/2]) rotate([0, 0, 90-angle/2]) corner(bevel_size=0.5);
        translate([outer_radius*sin(angle/2), outer_radius*cos(angle/2), -thickness/2]) rotate([0, 0, 90-angle/2]) mirror([0, 0, 1]) corner(bevel_size=0.5);
    }
    difference() {
        linear_extrude(thickness, center=true) difference() {
            circle(outer_radius);
            missing_piece_of_circle(radius=outer_radius, angle=angle);
        }
        sphere(ball_radius);
        top_bevel();
        mirror([0, 0, 1]) top_bevel();
        right_bevel();
        mirror([1, 0, 0]) right_bevel();
    }
}

ball_joint_stag_socket();