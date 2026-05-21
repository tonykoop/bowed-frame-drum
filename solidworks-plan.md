<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# SolidWorks Plan — Bowed Frame Drum

## Global Variables / Equations

Define all dimensions as global variables so the assembly parametrically updates:

```
"FrameOD"        = 450    mm
"FrameDepth"     = 90     mm
"WallThick"      = 1.0    mm
"FrameID"        = "FrameOD" - 2 * "WallThick"
"HeadPlayingOD"  = 430    mm
"RimStripW"      = 12     mm
"ToneBarL"       = 400    mm
"ToneBarW"       = 25     mm
"ToneBarH"       = 1.0    mm
"GrommetID"      = 6      mm
"WheelOD"        = 50     mm
"WheelW"         = 8      mm
```

## Feature Tree — Frame Ring Part (frame-ring.sldprt)

1. Sketch 1 (top plane): rectangle representing blank profile (1414.7 mm × 90 mm)
2. Sheet Metal: set thickness = WallThick, K-factor = 0.44, bend radius = 1.5 mm
3. Base Flange: extrude 90 mm (the frame height direction)
4. Rolled Bead: wrap the flat blank into a cylinder (SolidWorks Sheet Metal rolled bead)
   — this is done by inserting a rolled seam reference in the flat pattern
5. Flat Pattern: auto-generated; confirm OD = π × 450 = 1414.7 mm ± 0.5 mm
6. Cut-Extrude: 6× M4 tension holes, ø4.5 mm through, at 60° spacing on frame OD,
   centered at mid-depth (45 mm from each edge)
7. Weld-Nut bosses: note in drawing (not modeled — added at fab)
8. Mate reference: centerline axis for assembly placement

## Feature Tree — Tone Bar Part (tone-bar.sldprt)

1. Sheet Metal base: 400 mm × 25 mm × 1 mm flat plate
2. No bends — flat part
3. Cut-Extrude: 2× ø6 mm grommet slot holes, centered at 50 mm from each end
4. Flat Pattern: identical to blank (no bend development needed)

## Feature Tree — Tone Bar Mount Bracket (tone-bar-mount.sldprt)

1. Sheet Metal base: 30 mm × 25 mm blank
2. Edge Flange: 90° bend at 15 mm from one end → L-bracket
   - Long leg (15 mm): rivets to frame ID wall
   - Short leg (15 mm): has ø6 mm boss for grommet
3. Flat Pattern: 30 mm × 25 mm before bend

## Feature Tree — Rosined Wheel Arm (wheel-arm.sldprt)

1. Sheet Metal base: 80 mm × 15 mm blank
2. Edge Flange 1: 45° bend at 20 mm → offsets wheel toward head underside
3. Edge Flange 2: 45° return at 50 mm → returns arm parallel to frame for pivot mount
4. Cut: ø5.5 mm pivot hole at tail end (M5 clearance)
5. Flat Pattern: 80 mm × 15 mm (sum of developed arc sections)

## Feature Tree — Master Assembly (bowed-frame-drum.sldasm)

1. Insert frame-ring (fixed at origin)
2. Insert 2× tone-bar-mount brackets at 180° positions, 45 mm depth, riveted to frame ID
3. Insert tone-bar, dropped through grommet holes in mounts
4. Insert 2× neoprene grommets (bought component, simplified model)
5. Insert wheel-arm at 12 o'clock position, M5 pivot bolt through frame top edge
6. Insert brass wheel on pivot
7. Mates: coincident, parallel, concentric as required

## Configurations

| Config | Description |
|--------|-------------|
| Default | Standard assembly with wheel arm parked (disengaged) |
| Bowing | Wheel arm engaged, wheel contacts head underside at 5 mm inset |
| Flat patterns | Drive-by flat-pattern config for all sheet-metal parts |

## Drawings

- `drawings/frame-ring-flat.dxf` — frame blank flat pattern (plasma/laser cut)
- `drawings/frame-ring-fabrication.pdf` — dimensioned fab drawing
- `drawings/tone-bar-flat.dxf` — tone bar flat + grommet holes
- `drawings/mount-bracket-flat.dxf` — bracket flat + bend line
- `drawings/wheel-arm-flat.dxf` — wheel arm flat + two bend lines
- `drawings/assembly-overview.pdf` — exploded view with callouts
