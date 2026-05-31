(* Bowed Frame Drum — Wolfram Starter Acoustic Model
   SPDX-License-Identifier: CERN-OHL-W-2.0
   First-order sanity checks. Not final pitch predictors.
   Validates: head membrane modes, tone bar bending modes, sympathetic coupling. *)

(* Wolfram QA 2026-05-30: estimate - pending measurement, not fabrication authority.
   Variables and associations with Estimate suffix are planning values only unless
   later replaced by measured validation data or reviewed design-table authority. *)

ClearAll["Global`*"];

(* ============================================================
   Constants
   ============================================================ *)
c      = 343.0;   (* speed of sound m/s at 20C *)
a4     = 440.0;   (* Hz *)
rho    = 7850.0;  (* kg/m3 CR steel *)
EYoung = 2.0*^11;   (* Pa elastic modulus (renamed from E: E is Protected = Euler number; was 200e9, invalid WL sci-notation) *)
nu     = 0.29;    (* Poisson ratio *)


(* Helper: nearest note name (approximate) *)
NearestNote[hz_] := Module[{midi, noteNames, octave, noteName},
  midi = Round[69 + 12 Log[2, hz/440.0]];
  noteNames = {"C","C#","D","D#","E","F","F#","G","G#","A","A#","B"};
  octave = Floor[(midi - 12)/12];
  noteName = noteNames[[Mod[midi, 12] + 1]];
  StringJoin[noteName, ToString[octave]]
];

(* ============================================================
   1. CIRCULAR MEMBRANE — Bessel mode frequencies
   ============================================================
   f_{mn} = (alpha_{mn} / (2 Pi r)) * cMembraneEstimate
   where cMembraneEstimate = sqrt(T / sigma)
         T = surface tension [N/m]
         sigma = surface mass density [kg/m2]
         alpha_{mn} = n-th zero of Bessel J_m

   For a goatskin head at bodhran tension:
     sigmaHeadEstimate ≈ 0.35 kg/m2  (goatskin ~350 g/m2)
     Target f01 = 130 Hz → solve for T
*)

headRadiusEstimate = 0.215;   (* m = 430 mm / 2 *)
sigmaHeadEstimate = 0.35;    (* kg/m2 goatskin surface mass density *)

(* Bessel zeros alpha_{mn}: J_m(alpha) = 0 *)
(* alpha_01=2.4048, alpha_11=3.8317, alpha_21=5.1356, alpha_02=5.5201 *)
besselZeros = {
  {0, 1, 2.4048},
  {1, 1, 3.8317},
  {2, 1, 5.1356},
  {0, 2, 5.5201}
};

(* Solve for T from target fundamental f01 = 130 Hz *)
targetF01Estimate = 130.0;
THeadEstimate = sigmaHeadEstimate (2 Pi headRadiusEstimate targetF01Estimate / 2.4048)^2;

(* Membrane wave speed *)
cMembraneEstimate = Sqrt[THeadEstimate / sigmaHeadEstimate];

(* Compute all mode frequencies *)
membraneFreqs = Table[
  {StringJoin["f", ToString[row[[1]]], ToString[row[[2]]]],
   row[[1]], row[[2]], row[[3]],
   N[(row[[3]] / (2 Pi headRadiusEstimate)) * cMembraneEstimate]},
  {row, besselZeros}
];

membraneTable = Grid[
  Prepend[
    Map[{#[[1]], #[[2]], #[[3]], #[[4]], NumberForm[#[[5]], {5,1}], NearestNote[#[[5]]]} &,
        membraneFreqs],
    {"Mode", "m", "n", "alpha_mn", "freq_Hz", "nearest_note"}
  ],
  Frame -> All, Alignment -> Left
];

Print["=== Circular Membrane Modes ==="];
Print[membraneTable];
Print["Surface tension T = ", NumberForm[THeadEstimate, {5,2}], " N/m"];
Print["Membrane wave speed = ", NumberForm[cMembraneEstimate, {5,1}], " m/s"];

(* ============================================================
   2. TONE BAR — Euler-Bernoulli free-free bending modes
   ============================================================
   f_n = (lambda_n^2 / (2 Pi L^2)) * sqrt(E I / (rho A))
   Free-free boundary: lambda_n^2 = {22.373, 61.673, 120.903, 199.859, ...}
   For flat bar: I = b h^3 / 12 (bending about weak axis — width b, height h)
*)

barLEstimate = 0.400;   (* m tone bar length *)
barWEstimate = 0.025;   (* m tone bar width (bending axis) *)
barHEstimate = 0.001;   (* m tone bar thickness *)

Ibar = barWEstimate * barHEstimate^3 / 12;           (* second moment of area m^4 (renamed from I_bar: I is ImaginaryI, underscore makes a pattern) *)
Abar = barWEstimate * barHEstimate;                   (* cross-section area m^2 *)
kappaSq = EYoung * Ibar / (rho * Abar); (* stiffness parameter m^4/s^2 *)

(* Free-free lambda^2 values for first 4 modes *)
lambda2 = {22.3733, 61.6728, 120.9034, 199.8594};

barFreqs = Table[
  N[(lambda2[[n]] / (2 Pi barLEstimate^2)) * Sqrt[kappaSq]],
  {n, 1, 4}
];

Print["\n=== Tone Bar Bending Modes (free-free, weak-axis bending) ==="];
Do[
  Print["Mode ", n, ": ", NumberForm[barFreqs[[n]], {5,1}], " Hz  (", NearestNote[barFreqs[[n]]], ")"],
  {n, 1, 4}
];
Print["(trim bar shorter to raise pitch; add mass to lower pitch)"];

(* ============================================================
   3. SYMPATHETIC COUPLING CHECK
   ============================================================
   Coupling is effective when |f_bar_mode1 - f_membrane_mode| < 5%
   of the lower frequency.
*)

f01 = membraneFreqs[[1, 5]];
f11 = membraneFreqs[[2, 5]];
fbar1 = barFreqs[[1]];
fbar2 = barFreqs[[2]];

coupling01 = Abs[fbar1 - f01] / f01 * 100;
coupling11 = Abs[fbar1 - f11] / f11 * 100;
coupling01bar2 = Abs[fbar2 - f01] / f01 * 100;

Print["\n=== Sympathetic Coupling Check ==="];
Print["Head f01=", NumberForm[f01, {5,1}], " Hz vs bar mode1=", NumberForm[fbar1, {5,1}], " Hz → delta=", NumberForm[coupling01, {4,1}], "%"];
Print["Head f11=", NumberForm[f11, {5,1}], " Hz vs bar mode1=", NumberForm[fbar1, {5,1}], " Hz → delta=", NumberForm[coupling11, {4,1}], "%"];
Print["Head f01=", NumberForm[f01, {5,1}], " Hz vs bar mode2=", NumberForm[fbar2, {5,1}], " Hz → delta=", NumberForm[coupling01bar2, {4,1}], "%"];
Print["Coupling threshold: < 5% → strong; 5-15% → audible; > 15% → weak"];

(* ============================================================
   4. ROSINED WHEEL DRONE RANGE
   ============================================================
   Slip-stick oscillation: fundamental set by contact geometry
   and rosin viscosity. Practical bandwidth: 0.5× to 3× wheel rim speed.
   Wheel OD = 50 mm, typical bowing speed 0.2-1.0 m/s rim speed.
   Estimate: f = v_rim / (pi * d_wheel)  ... this is the rotation rate,
   not the acoustic output. The acoustic output is the membrane resonance
   excited by the periodic stick-slip.
*)

wheelODEstimate = 0.050;    (* m *)
vRimMinEstimate = 0.10;     (* m/s slow bow *)
vRimMaxEstimate = 0.80;     (* m/s fast bow *)
fRimMin = vRimMinEstimate / (Pi * wheelODEstimate);
fRimMax = vRimMaxEstimate / (Pi * wheelODEstimate);

Print["\n=== Rosined Wheel Excitation ==="];
Print["Wheel OD = ", wheelODEstimate*1000, " mm"];
Print["Rim rotation rate at slow bow: ", NumberForm[fRimMin, {4,1}], " Hz"];
Print["Rim rotation rate at fast bow: ", NumberForm[fRimMax, {4,1}], " Hz"];
Print["Acoustic drone = membrane resonance driven in this bandwidth"];
Print["Effective drone range: ", NumberForm[f01 * 0.8, {5,1}], " - ", NumberForm[f11 * 1.2, {5,1}], " Hz"];

(* ============================================================
   5. OUTPUT SUMMARY → matches validation.csv predicted column
   ============================================================ *)

Print["\n=== Predicted Values for validation.csv ==="];
Print["head_fundamental_hz,", NumberForm[f01, {5,1}]];
Print["head_overtone_f11_hz,", NumberForm[f11, {5,1}]];
Print["tone_bar_mode1_hz,", NumberForm[fbar1, {5,1}]];
Print["tone_bar_mode2_hz,", NumberForm[fbar2, {5,1}]];
Print["sympathetic_coupling_pct,", NumberForm[coupling11, {4,1}]];
Print["head_surface_tension_N_per_m,", NumberForm[THeadEstimate, {5,1}]];

(* ============================================================
   INTERACTIVE — Bowed Frame Drum estimator (EMPIRICAL ESTIMATES)
   Exposes real model parameters as controls and recomputes the
   membrane modes, tone-bar bending modes, and sympathetic coupling
   live via the same first-order physics used above.
   ============================================================ *)

Manipulate[
  Module[
    {Tval, cMem, mFreqs, kappaSq, Ibar, Abar, bFreqs, lam2, bz, f01v, f11v, fb1, cpl},
    bz = {{0, 1, 2.4048}, {1, 1, 3.8317}, {2, 1, 5.1356}, {0, 2, 5.5201}};
    (* surface tension implied by the target fundamental f01 *)
    Tval = sigmaHead (2 Pi headRadius targetF01 / 2.4048)^2;
    cMem = Sqrt[Tval / sigmaHead];
    mFreqs = Table[
      {StringJoin["f", ToString[row[[1]]], ToString[row[[2]]]],
       N[(row[[3]] / (2 Pi headRadius)) * cMem]},
      {row, bz}];
    (* tone-bar free-free bending modes (weak-axis) *)
    Ibar = barW barH^3 / 12;
    Abar = barW barH;
    kappaSq = EYoung Ibar / (rho Abar);
    lam2 = {22.3733, 61.6728, 120.9034, 199.8594};
    bFreqs = Table[N[(lam2[[n]] / (2 Pi barL^2)) Sqrt[kappaSq]], {n, 1, 4}];
    f01v = mFreqs[[1, 2]]; f11v = mFreqs[[2, 2]]; fb1 = bFreqs[[1]];
    cpl = Abs[fb1 - f11v] / f11v * 100;
    Column[{
      Style["Bowed Frame Drum — EMPIRICAL ESTIMATES (not fabrication authority)",
        Bold, Darker[Red]],
      Grid[
        Prepend[
          Map[{#[[1]], NumberForm[#[[2]], {5, 1}], NearestNote[#[[2]]]} &, mFreqs],
          {"Membrane mode (EST)", "freq Hz", "nearest note"}],
        Frame -> All, Alignment -> Left],
      Grid[
        Prepend[
          Table[{StringJoin["bar mode ", ToString[n]],
                 NumberForm[bFreqs[[n]], {5, 1}], NearestNote[bFreqs[[n]]]}, {n, 1, 4}],
          {"Tone-bar mode (EST)", "freq Hz", "nearest note"}],
        Frame -> All, Alignment -> Left],
      Grid[{
        {"Implied head tension (EST)", Row[{NumberForm[Tval, {5, 1}], " N/m"}]},
        {"Membrane wave speed (EST)", Row[{NumberForm[cMem, {5, 1}], " m/s"}]},
        {"Head f01 vs bar mode1 coupling (EST)", Row[{NumberForm[cpl, {4, 1}], " %"}]},
        {"Coupling verdict (EST)",
          Which[cpl < 5, "strong (<5%)", cpl < 15, "audible (5-15%)", True, "weak (>15%)"]}},
        Frame -> All, Alignment -> Left]
    }, Spacings -> 1]
  ],
  {{headRadius, 0.215, "head radius m — EMPIRICAL ESTIMATE"}, 0.10, 0.35, 0.005},
  {{sigmaHead, 0.35, "head surface mass kg/m^2 — EMPIRICAL ESTIMATE"}, 0.15, 0.60, 0.01},
  {{targetF01, 130.0, "target fundamental Hz — EMPIRICAL ESTIMATE"}, 60.0, 220.0, 1.0},
  {{barL, 0.400, "tone-bar length m — EMPIRICAL ESTIMATE"}, 0.20, 0.60, 0.005},
  {{barW, 0.025}, ControlType -> None},
  {{barH, 0.001}, ControlType -> None},
  ControlPlacement -> Left,
  SaveDefinitions -> True
]
