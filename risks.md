<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Risks — Bowed Frame Drum

## Safety Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| TIG burn-through on 1.0 mm sheet | Medium | Run coupon first; 60 A max; keep travel speed consistent; V-block fixture to prevent warping |
| Slip-roll nip point | High | Never feed fingers past roll nip; stop roll before removing workpiece |
| Grinder sparks near rosin | Medium | Keep rosin in closed container during grinding; clear flammables |
| Sharp edges on deburred parts | Low | Full deburr protocol (roto-cutter + stone); wear gloves during handling |

## Manufacturability Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Spring-back causes out-of-round frame | Medium | High | Mandatory coupon test before rolling full frame; adjust roll gap |
| TIG seam distorts frame from heat | Medium | Medium | Clamp in V-block jig; weld in short passes; allow cool-down between passes |
| Rim strip weld creates high spot on bearing edge | Low | High | Grind and check with straightedge; re-weld if needed |
| Wheel arm angle incorrect — wheel misses head | Medium | Medium | Prototype wheel arm in card stock first; verify geometry before cutting steel |
| Grommet press-fit too tight — damages grommet | Low | Low | Test grommet OD/hole diameter on scrap bracket before riveting to frame |

## Acoustic Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Head fundamental too low to reach with available tension | Low | High | Tune first without tone bar; if tension maxed at <100 Hz, head is too slack (replace with thinner synthetic head) |
| Tone bar coupling inaudible | Medium | Low | Coupling delta is 17.4% — audible but not locked. Shorten bar by 20 mm to raise f_bar to 280 Hz (closer to head overtone) |
| Rosined wheel produces only squeak, not sustained tone | Medium | Medium | Increase rosin thickness; reduce wheel contact pressure; experiment with slower bow speed |
| Frame resonance interferes with head tone | Low | Medium | Steel frame is ~20× stiffer than goatskin; frame breathing modes are above 500 Hz — unlikely to conflict |
| Sympathetic bar creates undesirable rattle | Low | Low | Grommet isolation prevents rattle; if rattle appears, add thin foam strip between bar and grommet |

## Ergonomic Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Frame too heavy for extended playing | Low | Mass budget ~900 g; lighter than many wood frames (900–1200 g for laminate). |
| Wheel arm scratches player's arm | Low | Bevel wheel arm tail; file all exposed corners |
| Tension screws back out during playing | Low | Apply threadlocker (Loctite 222) to all M4 tension screws after final tune |

## GitHub / Publishing Risk

- If `gh repo create` fails in sandbox environment: document in this file, proceed with local
  commits, and manager will push from WSL host.
- Status: `gh repo create` succeeded — no issue.
