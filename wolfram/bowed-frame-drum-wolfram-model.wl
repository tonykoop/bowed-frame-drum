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
E      = 200e9;   (* Pa elastic modulus *)
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

I_bar = barWEstimate * barHEstimate^3 / 12;           (* second moment of area m^4 *)
A_bar = barWEstimate * barHEstimate;                   (* cross-section area m^2 *)
kappa_sq = E * I_bar / (rho * A_bar); (* stiffness parameter m^4/s^2 *)

(* Free-free lambda^2 values for first 4 modes *)
lambda2 = {22.3733, 61.6728, 120.9034, 199.8594};

barFreqs = Table[
  N[(lambda2[[n]] / (2 Pi barLEstimate^2)) * Sqrt[kappa_sq]],
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
f_bar1 = barFreqs[[1]];
f_bar2 = barFreqs[[2]];

coupling01 = Abs[f_bar1 - f01] / f01 * 100;
coupling11 = Abs[f_bar1 - f11] / f11 * 100;
coupling01_bar2 = Abs[f_bar2 - f01] / f01 * 100;

Print["\n=== Sympathetic Coupling Check ==="];
Print["Head f01=", NumberForm[f01, {5,1}], " Hz vs bar mode1=", NumberForm[f_bar1, {5,1}], " Hz → delta=", NumberForm[coupling01, {4,1}], "%"];
Print["Head f11=", NumberForm[f11, {5,1}], " Hz vs bar mode1=", NumberForm[f_bar1, {5,1}], " Hz → delta=", NumberForm[coupling11, {4,1}], "%"];
Print["Head f01=", NumberForm[f01, {5,1}], " Hz vs bar mode2=", NumberForm[f_bar2, {5,1}], " Hz → delta=", NumberForm[coupling01_bar2, {4,1}], "%"];
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
Print["tone_bar_mode1_hz,", NumberForm[f_bar1, {5,1}]];
Print["tone_bar_mode2_hz,", NumberForm[f_bar2, {5,1}]];
Print["sympathetic_coupling_pct,", NumberForm[coupling11, {4,1}]];
Print["head_surface_tension_N_per_m,", NumberForm[THeadEstimate, {5,1}]];
