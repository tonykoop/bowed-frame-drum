<!-- SPDX-License-Identifier: CC-BY-4.0 -->
---
instrument: Bowed Frame Drum
family: membranophone
subfamily: frame-drum
origin_archetype: Irish bodhran
scale: chromatic sympathetic (tone bar tunable)
bore_profile: N/A (open frame cylinder)
target_fundamental_hz: 130
target_note: C3
tuning_mechanism: head-tension screws + tone-bar length trim
sheet_metal_challenge: rolled cylindrical frame + internal tone-bar suspension bracket
round: 5
lane: 05
version: v0.1.0-blueprint
date: 2026-05-21
---

# Bowed Frame Drum — Design Document

## Design Thesis

A bodhran-scale (~450 mm OD) frame drum with a rolled sheet-metal cylinder frame instead of
the traditional laminated wood hoop. Inside the frame a flat CR-steel tone bar is suspended
on two neoprene grommets; it vibrates sympathetically when the head is struck, adding an
overtone shimmer tuned to approximately C4 (260 Hz). An optional rosined-wheel assembly —
a 50 mm brass wheel on a cantilevered arm, rosined edge touching the head's inner rim —
produces a sustained bowed drone in the 80–400 Hz range when the arm is engaged.

The sheet-metal frame offers three advantages over wood: (1) dimensional precision from the
slip-roll, (2) weld-in grommet anchor points without splitting risk, (3) matte-black finish
gives a modern aesthetic while remaining acoustically transparent (the frame is a passive
radiator; head mass dominates).

## Geometry

```
Frame OD          : 450 mm
Frame ID          : 448 mm  (1 mm wall each side)
Frame depth       : 90 mm
Head playing OD   : 430 mm  (head slightly larger, clamped over rim)
Rim strip width   : 12 mm   (top + bottom, bent from 1 mm CR)
Tone bar          : 400 mm × 25 mm × 1 mm CR flat bar
Tone bar mount    : 2× brackets at 180° spacing, 50 mm from each end of bar
Grommet ID        : 5 mm  (bar thickness 1 mm; bar snaps into slot cut in grommet)
Rosined wheel OD  : 50 mm, brass, pivots on M5 stainless bolt
Rosined wheel arm : 60 mm × 15 mm × 1 mm CR, two 45° bends
```

## Acoustic Intent

| Mode | Target frequency | Note | Source |
|------|-----------------|------|--------|
| Head fundamental f₀₁ | ~130 Hz | C3 | Bessel J₀ first zero, tension tuned |
| Head overtone f₁₁ | ~220 Hz | A3 | Bessel mode 11; appears naturally |
| Tone bar bending mode 1 | ~260 Hz | C4 | Euler-Bernoulli free-free beam |
| Rosined wheel drone range | 80–400 Hz | — | Slip-stick excitation bandwidth |

The tone bar is intentionally detuned ~2 semitones above the head fundamental so sympathetic
ring decays slowly and adds air rather than masking. Trimming the bar shorter raises pitch;
adding blu-tack mass on the bar lowers pitch (field-adjustable).

## Sheet-Metal Authority Chain

### Frame ring
- Class: **cylinder**
- Material: 1.0 mm cold-rolled steel, ASTM A1008
- Blank: 1414.7 mm × 90 mm (π × 450 mm OD × depth)
- Seam: butt-TIG, full-penetration, fixture in V-block jig
- Spring-back: minimal on thin stock; overbend ~2° in slip-roll to compensate

### Rim reinforcement strips (×2)
- Class: **flat panel, rolled in-place**
- Blank: 1414.7 mm × 12 mm
- Operation: roll with frame; TIG-weld to top and bottom frame edges
- Provides: bearing surface for head wrap + stiffening ring against oval distortion

### Tone bar
- Class: **flat plate, no forming**
- Blank: 400 mm × 25 mm
- Operation: laser or plasma cut; edges deburred; no bends
- Suspend via 2× neoprene grommet mounts

### Tone bar mount brackets (×2)
- Class: **bracket, 1× 90° bend**
- Blank: 25 mm × 30 mm
- Bends: one 90° fold to form L; one leg rivets to frame ID wall, other leg cradles grommet

### Rosined wheel arm
- Class: **bracket, 2× bends**
- Blank: 80 mm × 15 mm
- Bends: 45° down at 20 mm from pivot end; 45° back at 50 mm (creates offset so wheel
  clears frame and contacts underside of head near rim)

## Seam Strategy

Butt + TIG throughout. Rationale: frame is structural (head tension ~60 N distributed),
butt-TIG is cleanest on 1.0 mm CR, lap joint would create inner ridge that snags head wrap.

## Tuning Mechanism

Head tension is set by 6× M4 × 30 mm cap-head screws threading into 6× M4 weld-nuts on the
frame OD, pulling a wrap-ring down over the head. Quarter-turn increments give ~8–12 Hz pitch
change at the fundamental. Tone bar pitch trimmed with angle grinder (shorten) or mass-loading.

## Ergonomics

Drum held in left arm, played with short tipper (traditional bodhran technique). Frame depth
90 mm provides grip without blocking playing hand. Rosined wheel arm on a spring-loaded pivot
— press with thumb to engage, release to disengage. Mass budget: frame ~700 g, head ~80 g,
hardware ~120 g, total ~900 g.
