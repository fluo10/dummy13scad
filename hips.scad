hip_width=16;
$fn=60;
eps=0.01;
module ball_joint() {
    joint_radius=3;
    bevel_height=0.5;

    difference() {
        sphere(joint_radius);
        translate([-joint_radius, -joint_radius, -joint_radius*3+bevel_height]) cube(joint_radius*2);
    }
    
}
module hip(width=hip_width) {
    base_radius=1.5;

    union(){
        ball_joint();
        translate([hip_width/2, 0, 0]) ball_joint();
        translate([-hip_width/2, 0, 0]) ball_joint();
        rotate([90, 0, 90]) difference(){
            cylinder(h=hip_width, r=base_radius, center=true);
            translate([0, -base_radius*2+0.2, 0]) cube([base_radius*2, base_radius*2, hip_width+eps], center=true);
        }
     
    }
}
hip();