<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Flat-Pattern Checklist — Bowed Frame Drum

## DXF Naming Convention

```
bfd-<part>-flat-v<rev>.dxf
Examples:
  bfd-frame-ring-flat-v1.dxf
  bfd-tone-bar-flat-v1.dxf
  bfd-mount-bracket-flat-v1.dxf
  bfd-wheel-arm-flat-v1.dxf
```

## Units

All DXFs in **millimeters**. Declare `$INSUNITS = 4` (mm) in DXF header.

## Layer Scheme

| Layer name | Color | Content |
|------------|-------|---------|
| `CUT` | Red (1) | Outer profile for plasma/laser cut path |
| `BENDS` | Yellow (2) | Bend center-lines (not cut) |
| `ETCH` | Cyan (4) | Reference marks, text labels |
| `HOLES` | Magenta (6) | Interior hole profiles |
| `DIMS` | White (7) | Dimension annotation (PDF export only) |

## Tab-and-Slot Strategy

Frame ring and tone bar have no tabs. Mount brackets use a single punched slot
(6 mm × 12 mm) in the long leg for rivet alignment. No interlocking tabs needed
because all structural joints are welded or riveted after forming.

## Part-by-Part Checklist

### Frame Ring Flat (bfd-frame-ring-flat-v1.dxf)
- [ ] Outer rectangle: 1414.7 mm × 90.0 mm on `CUT` layer
- [ ] 6× M4 tension holes (ø4.5 mm) at x = {78.5, 314.0, 549.5, 785.0, 1020.5, 1256.0} mm, y = 45.0 mm on `HOLES` layer
- [ ] Seam alignment etch marks at x = 0 and x = 1414.7 mm on `ETCH` layer
- [ ] Spring-back compensation note: overbend to ~178° in slip-roll

### Tone Bar Flat (bfd-tone-bar-flat-v1.dxf)
- [ ] Outer rectangle: 400.0 mm × 25.0 mm on `CUT` layer
- [ ] 2× grommet holes (ø6 mm) at x = {50, 350} mm, y = 12.5 mm on `HOLES` layer
- [ ] Centerline etch at y = 12.5 mm on `ETCH` layer

### Mount Bracket Flat (bfd-mount-bracket-flat-v1.dxf)
- [ ] Outer rectangle: 25.0 mm × 30.0 mm on `CUT` layer
- [ ] Bend line at y = 15.0 mm on `BENDS` layer
- [ ] 1× grommet boss hole (ø6 mm) at x = 12.5 mm, y = 22.5 mm (short leg center) on `HOLES` layer
- [ ] 2× rivet holes (ø3.3 mm for M3 rivet) at x = {7, 18} mm, y = 7.5 mm (long leg) on `HOLES` layer
- [ ] Bend direction arrow on `ETCH` layer

### Wheel Arm Flat (bfd-wheel-arm-flat-v1.dxf)
- [ ] Outer rectangle: 80.0 mm × 15.0 mm on `CUT` layer
- [ ] Bend line 1 at x = 19.5 mm (accounting for bend allowance for 45°) on `BENDS` layer
- [ ] Bend line 2 at x = 49.3 mm (after first bend allowance) on `BENDS` layer
- [ ] M5 pivot hole (ø5.5 mm) at x = 75 mm, y = 7.5 mm on `HOLES` layer
- [ ] Bend direction arrows on `ETCH` layer

## Bend Allowance Reference

Formula: BA = (π/180) × angle × (inside_radius + k × thickness)

| Part | Angle | Inside R (mm) | K | Thickness (mm) | BA (mm) |
|------|-------|--------------|---|----------------|---------|
| Mount bracket | 90° | 1.5 | 0.44 | 1.0 | 3.21 |
| Wheel arm bend 1 | 45° | 1.5 | 0.44 | 1.0 | 1.60 |
| Wheel arm bend 2 | 45° | 1.5 | 0.44 | 1.0 | 1.60 |

Frame ring and tone bar: no closed-form bends (rolled or flat).

## Nesting Notes

Plasma nest all 1.0 mm CR parts on a single 1500 mm × 500 mm sheet:
- Frame ring blank is the largest part and sets sheet height (90 mm → fits in 500 mm width)
- Nest frame ring first (1414.7 × 90 mm) with 5 mm edge margin
- Nest 2× mount brackets and 1× wheel arm and 1× tone bar in remaining space
- Lead-in: 5 mm external lead-in on all outer profiles

## Coupon Tests Required

1. **Slip-roll spring-back coupon**: Roll a 200 mm × 90 mm strip of the same 1.0 mm CR stock,
   measure actual OD vs target, adjust roll gap before running full frame blank.
2. **TIG butt-weld coupon**: Weld a 150 mm test strip butt joint, bend to fracture — confirm
   full fusion before welding frame seam.
