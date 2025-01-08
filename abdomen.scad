include <modules/config.scad>;
use <modules/common.scad>;
use <modules/ball_joint.scad>;

//if ($preview) {
//    color("red") {
//        import("references/frame-abdomen.stl");
//    }
//}

module abdomen (length) {
    
    module chest_joint() {
        translate([0, length, 0]) {
            sphere(3);
            rotate([90, 0, 0]) scraped_cylinder(h=4, r=1.5,  scraped_thickness=0.2);
        }
        
       
    }
    module base() {
        difference() {
            translate([0, 3, 0]) rotate([-90, 0, 0]) cylinder(h=length-7, r=3, center=false);
            translate([0, length-4, 0]) rotate([270, 0, 0]) rotate_edge(radius=3, bevel_size=0.5, angle=360, concave=false);
        }
    }
    module scraper() {
        translate([0, 2+length/2, 3]) cube([4, length, 1], center=true);
        translate([0, length-4, 2.5]) rotate([0, 270, 0]) linear_edge(length=4, bevel_size=0.5, center=true);
    }
    module side_bump() {
        radius=2;
        height=1.8;
        translate([1.2, 3, 0]) rotate([-90, 0, 0]) rotate_extrude() polygon([[0, 0], [0, height + radius], [radius, height], [radius, 0]]);
    }
    

    difference() {
        union(){
            chest_joint();
            base();
            rotate([0, 0, 180]) ball_joint_stag_socket(outer_radius=4.5, ball_radius=2.85, inner_radius=2.2, angle=112.5, thickness=5);
            side_bump();
            mirror([1, 0, 0]) side_bump();
        }
        scraper();
        mirror([0, 0, 1]) scraper();
        
    }
}
//abdomen(13);
//translate([10, 0, 0]) abdomen(10);
    
