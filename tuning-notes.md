<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Tuning Notes — Bowed Frame Drum

## Head Tuning

### Physics

The fundamental frequency of a circular membrane under uniform tension:

```
f₀₁ = (2.4048 / (2π r)) × √(T / σ)

where:
  r  = head radius = 0.215 m (430 mm / 2)
  T  = surface tension in N/m
  σ  = surface mass density in kg/m² (goatskin ≈ 0.35; Remo Skyndeep ≈ 0.25)
  2.4048 = first zero of Bessel function J₀
```

### Screw-Torque-to-Pitch Mapping

Each M4 × 30 mm cap screw applies ~100 N/mm torque conversion to head tension
(approximate; depends on head material and wrap geometry).

| Turns tightened | ΔT (N/m est.) | Δf₀₁ (Hz est.) |
|-----------------|---------------|-----------------|
| 1/4 turn | +12 N/m | +4–8 Hz |
| 1/2 turn | +24 N/m | +8–15 Hz |
| 1 full turn | +48 N/m | +15–30 Hz |

Always tighten in **star pattern** (positions 1-4-2-5-3-6) to maintain even tension.

### Target: C3 (130.8 Hz)

Strike center of head with finger; use chromatic tuner app. If fundamental is:
- **Below 115 Hz**: tighten all 6 screws 1 full turn star pattern; recheck
- **115–125 Hz**: tighten 1/2 turn star pattern
- **125–135 Hz**: tighten 1/4 turn at a time
- **Above 145 Hz**: loosen 1/4 turn star pattern

### Goatskin Humidity Sensitivity

Natural skin heads detune with humidity changes (pitch drops in high humidity).
Retune before each playing session. Store drum in stable humidity environment (40–60% RH).
Synthetic (Remo Skyndeep) is humidity-stable — tune once, check monthly.

## Tone Bar Tuning

### Target: C4 (261.6 Hz), mode 1 bending

The tone bar bending fundamental is set by its length:

```
f_bar1 = (22.3733 / (2π L²)) × √(E I / (ρ A))

where:
  L = bar length (m)
  I = b h³ / 12  (b=0.025m width, h=0.001m thickness)
  A = b × h
  E = 200 GPa, ρ = 7850 kg/m³
```

At L = 400 mm: f_bar1 ≈ 257 Hz (~C4 - 27 cents)

### Trimming Procedure

| Trim from each end | New f_bar1 (approx) |
|--------------------|---------------------|
| 0 mm (full 400 mm) | 257 Hz |
| 5 mm → 390 mm | 270 Hz |
| 10 mm → 380 mm | 285 Hz |
| 20 mm → 360 mm | 318 Hz |

Trim with angle grinder, 1 mm at a time from each end equally. Tap bar and measure
frequency with tuner app after each trim. Deburr cut end before reinstalling.

### Mass-Loading (No-Cut Adjustment)

Attach small pieces of blu-tack or putty at the center of the bar to lower pitch:
- ~1 gram at center → lowers f_bar1 by ~5–10 Hz
- Remove mass by peeling off

This is the safest first adjustment before committing to length trimming.

## Rosined Wheel Bowing

### Slip-Stick Mechanics

The wheel produces sustained sound via stick-slip oscillation where:
1. Wheel **sticks** to head surface due to rosin friction
2. Head membrane deflects until restoring force exceeds static friction
3. Wheel **slips** suddenly, membrane springs back
4. Cycle repeats at the head's natural resonant frequency

The acoustic output frequency is set by the **membrane resonance**, not the wheel rotation rate.
The wheel simply provides continuous excitation energy.

### Optimal Bowing Parameters

| Parameter | Optimum |
|-----------|---------|
| Wheel contact pressure | Light (50–100 g equivalent) |
| Bow speed (rim speed) | 0.2–0.5 m/s |
| Rosin freshness | Apply before each session |
| Head humidity | Dry is better (skin grips rosin better) |

### Drone Modes Available

- **Head fundamental (C3, 130 Hz)**: engage wheel with gentle pressure, slow bow
- **Head overtone (A3, 220 Hz)**: increase pressure + slightly faster bow; excites f₁₁ mode
- **Continuous sweep**: vary bow speed mid-stroke — pitch shifts as different modes lock
