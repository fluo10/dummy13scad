include <config.scad>;

module edge_profile(bevel_size) {
    polygon([[eps, eps], [-bevel_size, eps], [eps, -bevel_size]]);
}

module linear_edge(length, bevel_size=0.5, center=false){
    translate([0, 0, -eps]) linear_extrude(length+eps*2, center=center) edge_profile(bevel_size);
}

module rotate_edge(radius, bevel_size, angle=360) {
    rotate_extrude(angle=angle)translate([radius, 0, 0]) edge_profile(bevel_size);
}

module corner(bevel_size) {
    polyhedron([[eps, eps, eps], [-bevel_size-eps, -bevel_size-eps, eps], [eps, -bevel_size-eps, -bevel_size-eps], [-bevel_size-eps, eps, -bevel_size-eps]],[[0, 1, 3], [0, 2, 1], [0, 3, 2], [1, 2, 3]]);
}

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
