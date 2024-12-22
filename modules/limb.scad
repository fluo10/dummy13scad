include <config.scad>;
use <common.scad>;

module limb_base(length=10) {
    knee_joint_outer_radius =3;

    module hinge_joint() {
        module knee_joint_groove_profile() {
            size=1;
            polygon([[eps, size+eps],[-size, 0], [eps, -size-eps]]);
        }
        difference(){
            cylinder(h=5, r=2.5, center=true );
            translate([0, 0, 2.5]) rotate_edge(2.5, 0.5);
            translate([0, 0, -2.5]) rotate([180, 0, 0]) rotate_edge(2.5, 0.5);
            rotate_extrude() translate([2.5, 0, 0]) knee_joint_groove_profile() ;
        }
            
    }
            width=5;

    module base() {
        joint_width=3.2;
        module base_edge() {
            translate([width/2, 0, width/2]) rotate([270, 270, 0]) linear_edge(length, 0.5);
        }
        
        difference(){
            translate([-width/2,0, -width/2]) cube([width, length, width]);
            translate([-width/2-eps, -eps, -joint_width/2]) cube([width+2*eps, 5+eps, joint_width]);
            
            base_edge();
            mirror([1, 0, 0]) base_edge();
            mirror([0, 0, 1]) {
                base_edge();
                mirror([1, 0, 0]) base_edge();
            }
        } 
    }
    module joint_pit() {
        pit_depth=0.5;
        top_radius=1;
        translate([0, 0, width/2-pit_depth]) cylinder(pit_depth+eps, top_radius-pit_depth, top_radius+eps);
    }
        
    difference() {
        union() {
            hinge_joint();
            base();
        }
        joint_pit();
    }
    
}
limb_base(10);