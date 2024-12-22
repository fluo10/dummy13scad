include <modules/config.scad>;
use <modules/common.scad>;

hip_width=16;

module hips(width=hip_width) {
    base_radius=1.5;
    module ball_joint() {
        joint_radius=3;
        bevel_height=0.5;
        scraped_sphere(3, 0.5);
    }
    union(){
        ball_joint();
        translate([hip_width/2, 0, 0]) ball_joint();
        translate([-hip_width/2, 0, 0]) ball_joint();
        rotate([90, 0, 90]) scraped_cylinder(hip_width, base_radius, 0.2, center=true);
     
    }
}
hips();