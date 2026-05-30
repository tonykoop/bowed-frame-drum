<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Bowed Frame Drum

Status: L2 V5 build-packet candidate - organized for prototype/shop review,
but not L3/build-ready. CAD/DXF outputs are planned placeholders, acoustic
targets are unmeasured predictions, and fabrication authority remains
`pending_measurement` until physical validation and reviewed CAD/DXF exist.

**Family**: Membranophone — frame drum  
**Archetype**: Irish bodhran  
**Target tuning**: C3 fundamental (130.8 Hz), A3 first overtone (219 Hz)  
**Ergonomic envelope**: 450 mm OD × 90 mm deep, ~900 g

## Design Thesis

A bodhran-scale frame drum with a rolled 1.0 mm cold-rolled steel cylinder frame instead of
the traditional laminated wood hoop. Inside the frame, a flat CR-steel tone bar (400 × 25 × 1 mm)
is suspended on two neoprene grommets and vibrates sympathetically when the head is struck,
adding an overtone shimmer near C4 (257 Hz). An optional rosined brass wheel on a cantilevered
arm produces a sustained bowed drone in the 80–400 Hz range — transforming a percussion instrument
into a hybrid membranophone/bowed instrument.

## Quick Stats

| | |
|---|---|
| Frame OD | 450 mm |
| Frame depth | 90 mm |
| Frame material | 1.0 mm CR steel, ASTM A1008, butt-TIG seam |
| Head | Remo Skyndeep 18" or goatskin, 430 mm playing OD |
| Tone bar | 400 × 25 × 1 mm CR flat bar, grommet-suspended |
| Tone bar pitch | ~257 Hz (C4 − 27¢), trim-tunable |
| Bowing | Optional: 50 mm brass rosined wheel on pivot arm |
| Est. build cost | ~$107 USD (materials + bought head) |

## Repository Structure

```
design.md               parametric design + geometry narrative
parameters.csv          all dimensions with units and confidence
wolfram-starter.wl      acoustic model: Bessel membrane + Euler-Bernoulli bar modes
bom.csv                 full bill of materials
sourcing.csv            supplier SKUs and URLs
hardware.csv            fasteners and bought hardware
cut-list.csv            blank sizes and nesting notes
bend-table.csv          3 bends with allowance calculations
flat-pattern-checklist.md  DXF layers, naming, nesting
solidworks-plan.md      SolidWorks feature tree and global variables
fabrication-plan.md     14-step build sequence (Maker Nexus tools)
assembly-manual.md      final assembly steps + adjustment reference
validation.csv          target metrics with predicted values
tuning-notes.md         Bessel physics, screw-to-pitch mapping, bar trimming
risks.md                safety, manufacturability, acoustic, ergonomic risks
photo-shotlist.md       20 required shots for capstone deck
visual-bom-brief.md     brief for visual BOM illustration
visual-output-register.csv  V5 visual/CAD/DXF authority ledger
cad/mcp-session-log.md  V5 MCP/external-tool provenance stub
supplier-rfq.md         quote-ready RFQ text for sheet stock + head
explorer.html           interactive packet browser (Heifer Zephyr design language)
agent-record.md         session log: queries, assumptions, unknowns
drawings/               DXF flat patterns (stubs — populate with CAD)
cad/                    SolidWorks parts + assembly (stubs)
cnc/                    plasma/laser nesting plan (stubs)
learn-to-play/          bodhran technique stub
```

## License

- Hardware (CAD, DXF, BOM, fabrication plans): **CERN-OHL-W v2.0** — see LICENSE-HARDWARE.md
- Documentation (markdown, images): **CC BY 4.0** — see LICENSE-DOCS.md

---

*Round 5 Percussion — Lane 05 · Heifer Zephyr Instrument Series · v0.1.0-blueprint*
