# Design Intent — bowed-frame-drum rev A

- Master CAD: `cad/bowed-frame-drum.scad` (sha256: 49b67e8979124685d6403cfb49bb805301c27a05e9e0b7eb080d7504441c73cc), envelope driven by `parameters.csv` (sha256: 0d1d12fdfadbcc3626e6cf1e9334d37dfee6ff22caee456e86e5b9a592aa85e0).
- Function: Bodhran-scale steel frame drum bowed with a rosined wheel — a rolled cold-rolled-steel frame ring carries a single goatskin/synthetic head under 6-screw tension, with an internal steel tone bar tuned to couple with the head, and a rosined brass wheel that continuously excites the head to sustain a bowed tone.
- Environment: hand-held/stand-mounted acoustic instrument; steel frame under moderate distributed head tension (~60 N over 6 screws); head tension + tone-bar coupling are the tuned load path; synthetic head option resists humidity.
- Target qty: 1 (prototype). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Frame OD | 450 mm | round-out on slip-roll | head seating / scale | parameters.csv frame_od (high) |
| Frame depth | 90 mm | cut-list gate | resonance / handling | parameters.csv frame_depth (high) |
| Head playing OD | 430 mm | frame_id − 18 mm wrap clearance | fundamental pitch scaling | parameters.csv head_playing_od (high) |
| Head target fundamental | 130 Hz (C3) | measured after tuning | acoustic intent | parameters.csv head_target_fundamental (high) |
| Tone bar length | 400 mm | trimming raises f_bar | head/bar coupling | parameters.csv tone_bar_length (high) |
| Tension screws | 6 × M4, 60° spacing | even star-pattern tension | uniform head tension | parameters.csv tension_screw_qty (high) |
| Rosined wheel OD | 50 mm | pivot / contact setup | bowed excitation | parameters.csv rosined_wheel_od (med) |

## Incidental (free for DFM)

- External finish, wheel-arm cosmetic form, mount/stand solution, non-mating surface treatment.

## Must-nots (DFM may never violate)

- Do not feed fingers past the slip-roll nip; stop the roll before removing the workpiece (risks.md safety).
- Do not run head tension to maximum to chase pitch — if pitch stays <100 Hz at max tension the head is too slack; use a thinner synthetic head instead (risks.md).
- Do not treat tone-bar length as final — modal coupling (17.4% delta) may require shortening ~20 mm to raise f_bar toward the head overtone (risks.md / tuning-notes.md).
- Do not treat the .scad head_thickness or rosined-wheel/pivot detail as fabrication dimensions — envelope + assumptions only.

## Material intent

- Preferred: cold-rolled steel (ASTM A1008) frame, rim strip, tone bar; goatskin or Remo Skyndeep head; brass rosined wheel; M4 tension hardware per bom.csv / hardware.csv.
- Acceptable subs: per sourcing.csv (spec-first; live prices unverified).
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable. Status preserved at L2 V5 build-packet candidate.
