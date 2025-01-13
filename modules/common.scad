include <config.scad>;

module edge_profile(bevel_size) {
    polygon([[eps, eps], [-bevel_size, eps], [eps, -bevel_size]]);
}

module linear_edge(length, bevel_size=0.5, center=false){
    if(center) {
        linear_extrude(length+eps*2, center=center) edge_profile(bevel_size);
    } else {
        translate([0, 0, -eps]) linear_extrude(length+eps*2, center=center) edge_profile(bevel_size);
    }
}

module rotate_edge(radius, bevel_size, angle=360, concave=false) {
    if(concave) {
        rotate_extrude(angle=angle) union(){
            translate([radius, 0, 0]) rotate([0, 0, 90]) edge_profile(bevel_size);
            translate([radius/2+eps/2, -bevel_size/2+eps, 0]) square([radius+eps, bevel_size+2*eps], center=true);
        }
    } else {
        rotate_extrude(angle=angle)translate([radius, 0, 0]) edge_profile(bevel_size);
    }
}

rotate_edge(1, 0.5, concave=true);

module corner(bevel_size) {
    polyhedron([[eps, eps, eps], [-bevel_size-eps, -bevel_size-eps, eps], [eps, -bevel_size-eps, -bevel_size-eps], [-bevel_size-eps, eps, -bevel_size-eps]],[[0, 1, 3], [0, 2, 1], [0, 3, 2], [1, 2, 3]]);
}

module concaved_corner(bevel_size) {
    polyhedron([[eps, eps, eps], [-bevel_size-eps, eps, eps],[-bevel_size-eps,  -bevel_size-eps, eps], [eps, -bevel_size-eps, eps], [eps, eps, -bevel_size-eps]],[[0, 3, 2, 1], [0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4]]);
}

module beveled_cube(size, center=true, bevel_size=0.5, bevel_top=true, bevel_side=true, bevel_bottom=true) {
    module edges(){
        module top_edges(){
            module top_front_edge() {
                translate([0, size[1]/2, size[2]/2]) rotate([0, -90, 0]) linear_edge(length=size[0], bevel_size=bevel_size, center=true);
            }
            module top_right_edge() {
                translate([size[0]/2, 0, size[2]/2]) rotate([90, 0, 0]) linear_edge(length=size[1], bevel_size=bevel_size, center=true);
            }
                
            top_front_edge();
            mirror([0, 1, 0]) top_front_edge();
            top_right_edge();
            mirror([1, 0, 0]) top_right_edge();
        }
        module side_edges() {
            module front_right_edge() {
                translate([size[0]/2, size[1]/2, 0]) linear_edge(length=size[2], bevel_size=bevel_size, center=true);
            }
            front_right_edge();
            mirror([1, 0, 0]) front_right_edge();
            mirror([0, 1, 0]){
                front_right_edge();
                mirror([1, 0, 0]) front_right_edge();
            }
        }
        module top_corners() {
            module top_front_right_corner() {
                translate([size[0]/2, size[1]/2, size[2]/2]) corner(bevel_size=bevel_size);
            }
            top_front_right_corner();
            rotate([0, 0, 90]) top_front_right_corner();
            rotate([0, 0, 180]) top_front_right_corner();
            rotate([0, 0, 270]) top_front_right_corner();
        }

        if(bevel_top) top_edges();
        if(bevel_side) side_edges();
        if(bevel_bottom) mirror([0, 0, 1]) top_edges();
        if(bevel_top&&bevel_side) top_corners();
        if(bevel_bottom&&bevel_side) mirror([0, 0, 1]) top_corners();
    }
    
    difference(){
        cube(size, center=center);
        if(center) {
            edges();
        }else {
           translate([size[0]/2-eps, size[1]/2-eps, size[2]/2]-eps) edges();
        } 
    }
            
}    
beveled_cube([4, 5, 6], center=true, bevel_size=1, bevel_top=false, bevel_side=true, bevel_bottom=false);
module scraped_cylinder(h, r, scraped_thickness, center=false) {

    difference(){
        cylinder(h=h, r=r, center=center);
        if (center) {
            translate([0, -r*2+scraped_thickness, 0]) cube([r*2, r*2, h+eps], center=true);
        } else {
            translate([-r, -r*3+scraped_thickness, -eps]) cube([r*2, r*2, h+2*eps]);
        }
        
    }
}

module scraped_sphere(radius, scraped_thickness) {
    difference() {
        sphere(radius);
        translate([-radius, -radius, -radius*3+scraped_thickness]) cube(radius*2);
    }
}

