<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Agent Record — Bowed Frame Drum

- **Runtime**: Claude Sonnet 4.6 (claude-sonnet-4-6) via FleetView Claude Code
- **Skills loaded**: sheet-metal, instrument-maker
- **Date**: 2026-05-21

## qmd Queries Run

| Query | Collection | Key findings |
|-------|-----------|--------------|
| `qmd search "frame drum" -c instrument-builds` | instrument-builds | Found sprint triage docs noting `instrument-maker#83` (frame-drum) was closed; no prior build packet exists — this is a true greenfield |
| `qmd search "frame drum" -c instrument-wiki` | instrument-wiki | No frame drum wiki page exists; closest result was ceramic-hang membrane coupling patterns |
| `qmd vector_search "frame drum sheet metal membrane acoustic tuning"` | instrument-builds | No direct hits; confirms greenfield status |
| `qmd get /mnt/c/Users/Tony/Documents/GitHub/handpan/wolfram-starter.wl` | — | Used as Wolfram model template; adapted Bessel/plate model for membrane drum |
| `qmd get /mnt/c/Users/Tony/Documents/GitHub/handpan/design.md` | — | Used design.md frontmatter schema |

## Major Assumptions

1. **Head surface mass density**: assumed σ = 0.35 kg/m² for goatskin. Remo Skyndeep may be lighter (~0.25 kg/m²) — would raise predicted fundamental to ~155 Hz for same tension, meaning less screw torque needed to reach C3.

2. **Tone bar free-free BCs**: assumed both bar ends are truly free (unsupported). Grommet contact changes this slightly — actual mode 1 will be somewhat higher than 257 Hz depending on grommet stiffness. Treat 257 Hz as a lower bound; field trim to target.

3. **Head tension uniformity**: assumed uniform tension around circumference. Real bodhran heads with 6-screw tensioning have ±10–15% circumferential variation; actual fundamental may be ±10 Hz from prediction.

4. **Slip-roll spring-back**: 1.0 mm CR steel at 450 mm OD is a tight roll for most slip-rolls. Some machines need the third roll adjustment arm at maximum reach. Overbend 2° (target 358° arc) to compensate.

5. **Frame ID seam accessibility**: TIG welding the butt seam from the inside of a 448 mm ID × 90 mm deep cylinder is tight but feasible. A long reach TIG torch or inside-weld technique is required. Alternative: weld from outside only, but this means no internal flush grinding.

## Unknowns I'd Punt to Next Round

- **FEM validation** of head-bar sympathetic coupling: the Bessel + Euler-Bernoulli model gives first-order estimates only; FEM (ANSYS or Abaqus) would resolve whether the 17% coupling delta is sufficient for audible sympathetic ring.
- **Rosin formulation testing**: different rosins have very different slip-stick characteristics; recommend a 3-rosin comparison test (Hill, Pirastro Oliv, Hidersine) on the wheel.
- **Wheel arm spring design**: current design uses thumb-nut for tension adjustment. A leaf-spring detent (like a capo) would give cleaner engage/disengage; design deferred.
- **Bearing edge profile**: rim strip width (12 mm) and edge profile (sharp vs. 45° chamfer vs. round-over) affects head seating and sustain. Round-over of ~0.5 mm recommended but not detailed here.
- **CNC nesting plan**: `cnc/` directory stubbed. A full plasma nesting plan with lead-in/out and kerf compensation is needed before production.

## Files Produced

**Count**: 21 files across 6 directories

| File | Type |
|------|------|
| LICENSE | Combined license pointer |
| LICENSE-HARDWARE.md | CERN-OHL-W 2.0 |
| LICENSE-DOCS.md | CC BY 4.0 |
| README.md | Overview + repo map |
| design.md | Parametric design doc |
| parameters.csv | 47 parameters |
| bowed-frame-drum-starter.wl | Acoustic model (168 lines) |
| solidworks-plan.md | SW feature tree + global vars |
| flat-pattern-checklist.md | DXF naming, layers, nesting |
| bend-table.csv | 3 bends with allowances |
| cut-list.csv | 6 blank entries |
| fabrication-plan.md | 38-step build sequence |
| assembly-manual.md | Assembly + adjustment guide |
| bom.csv | 23 line items |
| sourcing.csv | 13 supplier entries |
| hardware.csv | 11 fastener/hardware entries |
| supplier-rfq.md | 3 RFQ blocks |
| validation.csv | 13 metrics with predictions |
| risks.md | Safety + mfg + acoustic + ergonomic |
| tuning-notes.md | Bessel physics + trim tables |
| photo-shotlist.md | 20 required shots |
| visual-bom-brief.md | BOM render brief |
| explorer.html | Interactive packet browser |
| agent-record.md | This file |
| learn-to-play/fingerings/basic-strokes.md | Bodhran technique stub |
| drawings/.gitkeep | DXF placeholder |
| cad/.gitkeep | CAD placeholder |

## Coupon Tests Recommended

1. Slip-roll spring-back coupon (200 × 90 mm strip) — critical before rolling frame
2. TIG butt-weld coupon (150 mm) — bend to fracture to verify fusion
3. Grommet press-fit coupon — verify 14 mm OD grommet fit in 13.8 mm hole without splitting

## Confidence

| Area | Confidence | Notes |
|------|-----------|-------|
| Acoustic targets | Medium | Bessel mode estimates ±10%; goatskin σ assumption unverified |
| Flat patterns | High | Frame ring geometry is elementary cylinder; tone bar/brackets trivial |
| Fabrication plan | High | All operations are standard Maker Nexus tooling; no exotic forming |
| BOM | High | All parts are commodity hardware; prices are current estimates |
| Sympathetic coupling | Low-Medium | 17% delta is borderline; needs physical test |
| Bowing mode | Medium | Slip-stick physics well understood; rosin formulation needs test |

## Suggested Next-Round Task

1. **Physical prototype**: build the frame ring (slip-roll + TIG); validate roundness.
2. **Tone bar acoustic test**: clamp tone bar in two grommets, strike with mallet, measure fundamental.
3. **CAD modeling**: build SolidWorks parametric assembly per `solidworks-plan.md`.
4. **Wiki page**: create `instrument-wiki/instruments/bowed-frame-drum.md` after prototype results.
5. **Learn-to-play expansion**: record audio examples of basic strokes + bowing mode.
