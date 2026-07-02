// bowed-frame-drum.scad — parametric frame + tone-bar + wheel envelope master
// =====================================================================
// SOURCE OF TRUTH: parameters.csv (design-intent parameter table) + design.md.
// AUTHORITY: pending_measurement. HONEST ENVELOPE SCAFFOLD, NOT fabrication
//   authority until reviewed against SolidWorks masters (solidworks-plan.md) or
//   measured prototype evidence.
//
// SCOPE / BOUNDARY (per V5 percussion addendum):
//   - Models the rolled steel FRAME ring + head disc + rim strip + tension-screw
//     field + internal tone bar (on its two mount brackets) + rosined-wheel
//     envelope, so overall geometry traces to parameters.csv.
//   - TUNING-SENSITIVE geometry is OUT OF SCOPE: exact tone-bar modal tuning,
//     rosined-wheel contact/pivot mechanism detail, and the head tension field
//     are hand-refined regions and are NOT modeled as fabrication solids.
//
// Render check: openscad -o /tmp/bowed-frame-drum-check.stl this-file (exit 0)
// =====================================================================

/* [Frame — parameters.csv] */
frame_od_mm        = 450;   // parameters.csv frame_od (bodhran scale)
wall_thickness_mm  = 1.0;   // parameters.csv wall_thickness (ASTM A1008 CR)
frame_depth_mm     = 90;    // parameters.csv frame_depth
rim_strip_width_mm = 12;    // parameters.csv rim_strip_width

/* [Head — parameters.csv] */
head_playing_od_mm = 430;   // parameters.csv head_playing_od
head_thickness_mm  = 0.5;   // ASSUMPTION: drum-head sheet ~0.5 mm (Skyndeep/goatskin)

/* [Tension screws — parameters.csv] */
tension_screw_qty  = 6;     // parameters.csv tension_screw_qty (60-deg spacing)
tension_screw_dia  = 4;     // parameters.csv tension_screw_size M4

/* [Tone bar — parameters.csv] */
tone_bar_length_mm    = 400; // parameters.csv tone_bar_length
tone_bar_width_mm     = 25;  // parameters.csv tone_bar_width
tone_bar_thickness_mm = 1.0; // parameters.csv tone_bar_thickness
mount_bracket_spacing = 300; // parameters.csv mount_bracket_spacing (c-c)
mount_bracket_l_mm    = 30;  // parameters.csv mount_bracket_blank_l

/* [Rosined wheel — parameters.csv] */
wheel_od_mm    = 50;   // parameters.csv rosined_wheel_od
wheel_width_mm = 8;    // parameters.csv rosined_wheel_width

/* [Render] */
$fn = 120;
show_head = true;

// Derived (formulas) -----------------------------------------------
frame_or = frame_od_mm / 2;
frame_ir = frame_or - wall_thickness_mm;   // parameters.csv frame_id/2 = 448/2
head_r   = head_playing_od_mm / 2;
screw_circle_r = frame_or - rim_strip_width_mm / 2;

// Rolled steel frame ring ------------------------------------------
module frame_ring() {
    difference() {
        cylinder(h = frame_depth_mm, r = frame_or);
        translate([0, 0, -1]) cylinder(h = frame_depth_mm + 2, r = frame_ir);
    }
}

// Rim bearing strip (top, inward flange) ---------------------------
module rim_strip() {
    translate([0, 0, frame_depth_mm - rim_strip_thickness()])
        difference() {
            cylinder(h = rim_strip_thickness(), r = frame_ir);
            translate([0, 0, -1])
                cylinder(h = rim_strip_thickness() + 2,
                         r = frame_ir - rim_strip_width_mm);
        }
}
function rim_strip_thickness() = wall_thickness_mm;  // rim_strip_thickness param

// Head disc (single playing surface) -------------------------------
module head() {
    translate([0, 0, frame_depth_mm])
        cylinder(h = head_thickness_mm, r = head_r);
}

// Tension screw field (M4 x qty, 60-deg spacing) -------------------
module tension_screws() {
    for (i = [0 : tension_screw_qty - 1])
        rotate([0, 0, i * 360 / tension_screw_qty])
            translate([screw_circle_r, 0, frame_depth_mm - 15])
                cylinder(h = 18, r = tension_screw_dia / 2);
}

// Internal tone bar on two mount brackets --------------------------
module tone_bar() {
    z = frame_depth_mm / 2;
    // bar
    translate([-tone_bar_length_mm/2, -tone_bar_width_mm/2, z])
        cube([tone_bar_length_mm, tone_bar_width_mm, tone_bar_thickness_mm]);
    // two mount brackets
    for (s = [-1, 1])
        translate([s * mount_bracket_spacing/2 - mount_bracket_l_mm/2,
                   -tone_bar_width_mm/2, 0])
            cube([mount_bracket_l_mm, tone_bar_width_mm, z]);
}

// Rosined wheel envelope (bowing wheel) ----------------------------
module rosined_wheel() {
    translate([head_r + wheel_od_mm/2 + 5, 0, frame_depth_mm/2])
        rotate([90, 0, 0])
            cylinder(h = wheel_width_mm, r = wheel_od_mm/2, center = true);
}

// Assembly ---------------------------------------------------------
module bowed_frame_drum() {
    color("SlateGray") frame_ring();
    color("Silver")    rim_strip();
    color("DimGray")   tension_screws();
    color("Goldenrod") tone_bar();
    color("DarkGoldenrod") rosined_wheel();
    if (show_head) color("Tan") head();
}

bowed_frame_drum();

echo(str("frame_or = ", frame_or, " mm; head_r = ", head_r,
         " mm; screws = ", tension_screw_qty, " x M", tension_screw_dia));
