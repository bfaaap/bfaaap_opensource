#!/usr/bin/env python3
"""
bFaaaP paper figures — generator.

Creates publication-quality figures at >= 300 DPI for the arXiv preprint.
Each figure is produced both as a vector PDF (used by LaTeX) and as a
600-DPI PNG (raster, as requested). Edit the small functions below to tweak
any figure, then re-run:

    python3 scripts.py

Requires: matplotlib, numpy (use the environment that has them).
"""
import os
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch, Ellipse, Rectangle

OUT = os.path.dirname(os.path.abspath(__file__))
DPI = 600  # >= 300 (raster). PDF output is vector (resolution-independent).

plt.rcParams.update({
    "font.size": 10,
    "font.family": "DejaVu Sans",
    "axes.linewidth": 0.8,
    "savefig.bbox": "tight",
    "savefig.pad_inches": 0.05,
})

BLUE_F, BLUE_E = "#eaf1fb", "#2f5597"
GREEN_F, GREEN_E = "#e9f6ec", "#2e7d32"
GREY_F, GREY_E = "#f0f0f0", "#555555"
ORANGE_F, ORANGE_E = "#fdeedd", "#c5701a"


def save(fig, name):
    # Pass dpi to the PDF too: vector elements stay resolution-independent, but
    # any embedded raster photos (Figure 1) are sampled at >= 300 DPI so the
    # composite does not lose resolution.
    fig.savefig(os.path.join(OUT, name + ".pdf"), dpi=DPI)
    fig.savefig(os.path.join(OUT, name + ".png"), dpi=DPI)
    plt.close(fig)
    print("wrote", name + ".pdf /", name + ".png")


def box(ax, x, y, w, h, text, fc=BLUE_F, ec=BLUE_E, fs=9):
    ax.add_patch(FancyBboxPatch((x, y), w, h,
                 boxstyle="round,pad=0.02,rounding_size=0.06",
                 linewidth=1.2, edgecolor=ec, facecolor=fc))
    ax.text(x + w / 2, y + h / 2, text, ha="center", va="center", fontsize=fs)
    return (x, y, w, h)


def arrow(ax, p1, p2, label=None, lw=1.4, color="#222222", rad=0.0, fs=8, loff=(0, 0.12)):
    ax.add_patch(FancyArrowPatch(p1, p2, arrowstyle="-|>", mutation_scale=12,
                 linewidth=lw, color=color,
                 connectionstyle=f"arc3,rad={rad}"))
    if label:
        mx, my = (p1[0] + p2[0]) / 2 + loff[0], (p1[1] + p2[1]) / 2 + loff[1]
        ax.text(mx, my, label, ha="center", va="center", fontsize=fs, color=color)


# ---------------------------------------------------------------- Figure 1
def fig_architecture():
    fig, ax = plt.subplots(figsize=(9.4, 3.9))
    ax.set_xlim(0, 12.95); ax.set_ylim(0, 4.7); ax.axis("off")

    ax.text(0.52, 2.45, "Player\nhead motion", ha="center", va="center", fontsize=8.6)
    A = box(ax, 1.35, 1.82, 2.80, 1.28, "iOS controller\n(ARKit face tracking,\nCoreBluetooth)", fs=8.2)
    B = box(ax, 5.10, 1.82, 2.05, 1.28, "BLE board\n(nRF52840,\nBluefruit)", fs=8.2)
    SW = box(ax, 8.55, 3.28, 4.05, 0.98, "Sustain-pedal jack\n(Switch: electronic)", fc=GREEN_F, ec=GREEN_E, fs=8.2)
    C = box(ax, 8.55, 1.88, 4.05, 0.98, "Pico main board\n(RP2040)", fs=8.2)
    D = box(ax, 8.55, 0.42, 4.05, 0.98, "motor -> belt -> leadscrew ->\npush-rod -> pedal (Pro)", fc=ORANGE_F, ec=ORANGE_E, fs=8.2)

    arrow(ax, (1.00, 2.45), (1.35, 2.45))
    arrow(ax, (4.15, 2.45), (5.10, 2.45))
    # label lifted above the box tops (y=3.10) so it never overlaps either box
    ax.text(4.62, 3.62, "BLE (NUS):\nvalues + N/F", ha="center", va="center", fontsize=7.4)
    # BLE board -> Switch jack (curved up) and -> Pico (horizontal)
    ax.add_patch(FancyArrowPatch((7.15, 2.80), (8.55, 3.62), arrowstyle="-|>",
                 mutation_scale=12, lw=1.4, color="#222222",
                 connectionstyle="arc3,rad=0.18"))
    ax.text(7.42, 3.42, "GP13\non/off", ha="left", va="center", fontsize=7.3)
    arrow(ax, (7.15, 2.22), (8.55, 2.30))
    # UART label sits in the (widened) gap, above the arrow and clear of both boxes
    ax.text(7.85, 2.54, "UART (1 byte)", ha="center", va="bottom", fontsize=7.2)
    arrow(ax, (10.22, 1.88), (10.22, 1.40))
    ax.text(10.48, 1.64, "drive", ha="left", va="center", fontsize=7.6, color="#222")
    save(fig, "fig_architecture")


# ---------------------------------------------------------------- Figure 2
def fig_control():
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(7.6, 2.9))

    # (a) value mapping  v = clamp(g*(theta - theta0), 0, 99)
    theta0, g = 5.0, 9.0
    x = np.linspace(0, 20, 400)
    v = np.clip(g * (x - theta0), 0, 99)
    ax1.plot(x, v, color=BLUE_E, lw=2)
    ax1.axvline(theta0, color=GREY_E, ls="--", lw=1)
    ax1.text(theta0 + 0.3, 8, r"$\theta_0$ (neutral)", fontsize=8, color=GREY_E)
    ax1.axhline(99, color=ORANGE_E, ls=":", lw=1)
    ax1.text(12.5, 92, "clamp at 99", fontsize=8, color=ORANGE_E)
    ax1.set_xlabel(r"head pitch $\theta$ (deg, downward)")
    ax1.set_ylabel("transmitted value $v$")
    ax1.set_title("(a) angle to pedal value", fontsize=9)
    ax1.set_xlim(0, 20); ax1.set_ylim(-3, 108)
    ax1.grid(alpha=0.25)

    # (b) hysteresis engage/release
    tau, delta = 8.0, 1.5
    ax2.set_xlim(0, 16); ax2.set_ylim(-0.25, 1.35)
    ax2.set_xlabel(r"head angle above neutral $(\theta-\theta_0)$ (deg)")
    ax2.set_ylabel("pedal state")
    ax2.set_yticks([0, 1]); ax2.set_yticklabels(["released", "engaged"])
    ax2.set_title("(b) engage/release hysteresis", fontsize=9)
    # forward (increasing): release until tau, then engage
    ax2.plot([0, tau, tau, 16], [0, 0, 1, 1], color=GREEN_E, lw=2, label="increasing")
    # backward (decreasing): engaged until tau-delta, then release
    ax2.plot([16, tau - delta, tau - delta, 0], [1, 1, 0, 0], color=BLUE_E, lw=2, ls="--", label="decreasing")
    ax2.axvspan(tau - delta, tau, color="#ffe9c9", alpha=0.7)
    ax2.text((tau - delta + tau) / 2, 0.5, "dead-\nband $\\delta$", ha="center", va="center", fontsize=7.5)
    ax2.annotate(r"engage at $\tau$", (tau, 1.02), (tau - 4.5, 1.18), fontsize=8,
                 arrowprops=dict(arrowstyle="->", color=GREEN_E))
    ax2.annotate(r"release at $\tau-\delta$", (tau - delta, -0.02), (tau - 0.5, -0.2), fontsize=8,
                 arrowprops=dict(arrowstyle="->", color=BLUE_E))
    ax2.legend(fontsize=7.5, loc="center right")
    ax2.grid(alpha=0.25)
    fig.tight_layout()
    save(fig, "fig_control")


# ---------------------------------------------------------------- Figure 3
def fig_rate_decoupling():
    fig, ax = plt.subplots(figsize=(7.6, 2.5))
    ax.set_xlim(-8, 210); ax.set_ylim(0, 3.2); ax.axis("off")
    T = 200
    # AR frames ~60 fps (16.7 ms)
    ax.hlines(2.4, 0, T, color=GREY_E, lw=1)
    for t in np.arange(0, T + 1, 1000.0 / 60.0):
        ax.vlines(t, 2.25, 2.55, color=BLUE_E, lw=1)
    ax.text(-6, 2.4, "AR\n~60 fps", ha="right", va="center", fontsize=8, color=BLUE_E)
    ax.text(T + 3, 2.4, "stores latest\nangle (shared var)", ha="left", va="center", fontsize=7.5)

    # BLE sends every 100 ms
    ax.hlines(0.8, 0, T, color=GREY_E, lw=1)
    for t in [0, 100, 200]:
        ax.vlines(t, 0.62, 0.98, color=ORANGE_E, lw=2.2)
        ax.add_patch(FancyArrowPatch((t, 2.20), (t, 1.00), arrowstyle="-|>",
                     mutation_scale=10, color="#999999", lw=1, ls="--"))
    ax.text(-6, 0.8, "BLE\n10 Hz\n(100 ms)", ha="right", va="center", fontsize=8, color=ORANGE_E)
    ax.text(T + 3, 0.8, "samples & sends", ha="left", va="center", fontsize=7.5)

    ax.annotate("", (185, 2.4), (165, 2.4), arrowprops=dict(arrowstyle="<->", color=GREY_E))
    ax.text(175, 2.62, "16.7 ms", ha="center", fontsize=7, color=GREY_E)
    ax.annotate("", (100, 0.45), (0, 0.45), arrowprops=dict(arrowstyle="<->", color=GREY_E))
    ax.text(50, 0.30, "100 ms", ha="center", fontsize=7, color=GREY_E)
    ax.set_title("AR sampling rate decoupled from BLE send rate (via one shared variable)",
                 fontsize=9)
    save(fig, "fig_rate_decoupling")


# ---------------------------------------------------------------- Figure 4
def fig_pro_mechanism():
    fig, ax = plt.subplots(figsize=(7.4, 3.7))
    ax.set_xlim(0, 10.6); ax.set_ylim(0, 5.5); ax.axis("off")
    # floor
    ax.hlines(0.5, 0.3, 10.3, color="#888", lw=1.5)
    ax.add_patch(Rectangle((0.3, 0.2), 10.0, 0.3, facecolor="#eeeeee", edgecolor="none"))
    # frame (aluminium extrusion)
    ax.add_patch(Rectangle((1.05, 0.5), 0.26, 3.95, facecolor="#cfd6dd", edgecolor="#555"))
    ax.text(0.80, 2.45, "aluminium\nframe", fontsize=8, ha="right", rotation=90, va="center")
    # motor
    ax.add_patch(FancyBboxPatch((1.55, 3.05), 1.55, 1.05, boxstyle="round,pad=0.02",
                 facecolor=ORANGE_F, edgecolor=ORANGE_E, lw=1.3))
    ax.text(2.32, 3.57, "motor", fontsize=8.5, ha="center", va="center")
    # belt/pulleys (motor -> leadscrew) with label placed clear above both
    ax.plot([3.10, 3.95], [3.78, 3.55], color="#444", lw=2)
    ax.plot([3.10, 3.95], [3.42, 3.05], color="#444", lw=2)
    ax.annotate("", (3.5, 3.62), (3.5, 4.55), arrowprops=dict(arrowstyle="-", color="#999", lw=0.8))
    ax.text(3.5, 4.62, "2GT belt + pulleys", fontsize=8, ha="center", va="bottom")
    # leadscrew + nut
    ax.add_patch(Rectangle((3.95, 2.45), 0.4, 1.55, facecolor="#dddddd", edgecolor="#555", hatch="----"))
    ax.text(4.55, 3.28, "lead screw (T10)\n+ nut", fontsize=8, ha="left", va="center")
    # push-rod down onto pedal
    ax.add_patch(Rectangle((4.00, 0.95), 0.30, 1.55, facecolor="#cccccc", edgecolor="#555"))
    ax.text(4.55, 1.65, "push-rod", fontsize=8, ha="left", va="center")
    # sustain pedal (lever) being pressed
    ax.plot([2.2, 4.25], [1.5, 0.98], color="#b8860b", lw=4)
    ax.text(2.30, 1.86, "sustain pedal", fontsize=8, ha="left", color="#7a5b08")
    # neighbouring pedal + airback
    ax.plot([6.5, 8.7], [1.25, 1.25], color="#b8860b", lw=4)
    ax.text(7.60, 1.58, "neighbouring pedal", fontsize=8, ha="center", color="#7a5b08")
    ax.add_patch(Ellipse((7.60, 0.88), 2.0, 0.62, facecolor="#bcd2f0", edgecolor=BLUE_E, lw=1.3))
    ax.text(7.60, 0.88, "airback (inflated)", fontsize=8, ha="center", va="center")
    ax.add_patch(FancyArrowPatch((7.60, 1.00), (7.60, 1.23), arrowstyle="-|>",
                 mutation_scale=10, color=BLUE_E, lw=1.5))
    ax.text(8.78, 0.88, "absorbs\nreaction\nforce", fontsize=7.5, ha="left", va="center", color=BLUE_E)
    ax.set_title("Pro device: motor drivetrain + airback reaction-force anchoring", fontsize=9.5)
    save(fig, "fig_pro_mechanism")


# ---------------------------------------------------------------- Figure 0 (overview)
def _overview_diagram(ax):
    """Vertical operating-principle flow drawn into the given axis (0..10)."""
    ax.set_xlim(0, 10); ax.set_ylim(0, 10); ax.axis("off")
    ax.set_title("(c) operating principle", fontsize=8.6)
    box(ax, 2.6, 8.65, 4.8, 1.00, "Player tilts head\n(up / down)", fc=GREY_F, ec=GREY_E, fs=8.2)
    box(ax, 1.7, 6.75, 6.6, 1.35, "Smartphone AI\n(ARKit face tracking)\n+ paced BLE send (100 ms)", fs=8.0)
    box(ax, 3.0, 4.55, 4.0, 1.00, "Pedal device", fc=GREY_F, ec=GREY_E, fs=8.4)
    box(ax, 0.10, 2.50, 4.60, 1.35, "Pro: motor presses\nacoustic pedal", fc=ORANGE_F, ec=ORANGE_E, fs=7.9)
    box(ax, 5.30, 2.50, 4.60, 1.35, "Switch: electronic\nsustain switch (digital)", fc=GREEN_F, ec=GREEN_E, fs=7.9)
    box(ax, 2.7, 0.40, 4.6, 1.05, "Note sustains while\nhead stays tilted", fc=BLUE_F, ec=BLUE_E, fs=8.2)
    A = "#333"
    ax.add_patch(FancyArrowPatch((5.0, 8.65), (5.0, 8.12), arrowstyle="-|>", mutation_scale=11, color=A))
    ax.add_patch(FancyArrowPatch((5.0, 6.75), (5.0, 5.57), arrowstyle="-|>", mutation_scale=11, color=A))
    ax.text(5.30, 6.16, "BLE (Nordic UART):\niNN + N/F", ha="left", va="center", fontsize=6.8)
    ax.add_patch(FancyArrowPatch((4.0, 4.55), (2.40, 3.88), arrowstyle="-|>", mutation_scale=10, color=A))
    ax.add_patch(FancyArrowPatch((6.0, 4.55), (7.60, 3.88), arrowstyle="-|>", mutation_scale=10, color=A))
    ax.add_patch(FancyArrowPatch((2.40, 2.50), (4.4, 1.48), arrowstyle="-|>", mutation_scale=10, color=A))
    ax.add_patch(FancyArrowPatch((7.60, 2.50), (5.6, 1.48), arrowstyle="-|>", mutation_scale=10, color=A))


def fig_overview():
    """Figure 1 overview from real photos (two each: iOS, Pro, Switch) plus the
    operating-principle diagram. Photos are read at native resolution and embedded
    at >= 300 DPI (see save(): PDF raster dpi); lanczos resampling avoids softness.
    Photos:
      ov_ios_neutral.png / ov_ios_engaged.png  (iOS UI: white -> red feedback)
      ov_pro_device.jpg  / ov_pro_controller.jpg (Pro device + hand controller)
      ov_switch_setup.jpg / ov_switch_leds.png   (Switch on a keyboard + LED states)
    """
    names = {
        "ios_n": "ov_ios_neutral.png", "ios_e": "ov_ios_engaged.png",
        "pro_dev": "ov_pro_device.jpg", "pro_ctrl": "ov_pro_controller.jpg",
        "sw_set": "ov_switch_setup.jpg", "sw_led": "ov_switch_leds.png",
    }
    im = {k: mpimg.imread(os.path.join(OUT, v)) for k, v in names.items()}

    def photo(ax, key, label, sub):
        ax.imshow(im[key], interpolation="lanczos")
        ax.axis("off")
        ax.set_title(f"{label} {sub}", fontsize=8.0)

    fig = plt.figure(figsize=(7.6, 9.1))
    outer = fig.add_gridspec(3, 1, height_ratios=[1.30, 1.0, 1.0], hspace=0.22)

    # Row 1 -- shared iOS controller (white -> red) + operating-principle diagram
    r0 = outer[0].subgridspec(1, 3, width_ratios=[0.62, 0.62, 1.90], wspace=0.07)
    photo(fig.add_subplot(r0[0]), "ios_n", "(a)", "iOS\nneutral (white)")
    photo(fig.add_subplot(r0[1]), "ios_e", "(b)", "iOS\nengaged (red)")
    _overview_diagram(fig.add_subplot(r0[2]))

    # Row 2 -- Pro (acoustic): device on the pedal + hand controller
    r1 = outer[1].subgridspec(1, 2, width_ratios=[1.18, 0.82], wspace=0.04)
    photo(fig.add_subplot(r1[0]), "pro_dev", "(d)", "Pro device pressing an acoustic pedal")
    photo(fig.add_subplot(r1[1]), "pro_ctrl", "(e)", "Pro hand controller\n(slider + on/off)")

    # Row 3 -- Switch (electronic/digital): on a keyboard + status LEDs
    r2 = outer[2].subgridspec(1, 2, width_ratios=[1.12, 0.88], wspace=0.06)
    photo(fig.add_subplot(r2[0]), "sw_set", "(f)", "Switch on a digital keyboard (with iOS app)")
    photo(fig.add_subplot(r2[1]), "sw_led", "(g)", "Switch status LED\noff / ready / engaged")

    save(fig, "fig_overview")


# ------------------------------------------------ Figure: control vs prior art
def fig_control_vs_priorart():
    """The key novelty visual: bFaaaP's quantitative, user-tunable mapping
    (offset dead-zone + user multiplier -> continuous, proportional pedal command)
    vs. binary on/off prior art (a head switch). Patent-validated ranges."""
    fig, ax = plt.subplots(figsize=(7.0, 3.1))
    x = np.linspace(0, 20, 500)
    # prior art: binary on/off at a fixed threshold (~8 deg), full or nothing
    prior = np.where(x >= 8, 99, 0)
    ax.step(x, prior, where="post", color=GREY_E, lw=2.0, ls="--",
            label="prior art: binary on/off (head switch)")
    # bFaaaP: offset dead-zone + user-selected multiplier (two example settings)
    for off, m, c, lab in [(5, 10, BLUE_E, "bFaaaP: offset 5$^{\\circ}$, $m{=}10$"),
                           (3, 30, GREEN_E, "bFaaaP: offset 3$^{\\circ}$, $m{=}30$")]:
        v = np.clip((x - off) * m, 0, 99)
        ax.plot(x, v, color=c, lw=2.2, label=lab)
    ax.axvspan(0, 5, color="#f2f2f2", alpha=0.8)
    ax.text(2.4, 52, "dead-zone\n(offset, $3$--$10^{\\circ}$)", ha="center", va="center",
            fontsize=7.2, color=GREY_E, rotation=90)
    ax.annotate("user-tunable\nslope = multiplier\n($10$--$50$)", (7.0, 40), (10.5, 22),
                fontsize=7.6, color=BLUE_E,
                arrowprops=dict(arrowstyle="->", color=BLUE_E))
    ax.set_xlabel(r"head pitch above neutral (deg)")
    ax.set_ylabel("pedal command (0--99)")
    ax.set_title("Quantitative, user-tunable mapping vs. binary prior art", fontsize=9.5)
    ax.set_xlim(0, 20); ax.set_ylim(-4, 110)
    ax.grid(alpha=0.25); ax.legend(fontsize=7.4, loc="lower right")
    save(fig, "fig_control_vs_priorart")


# ------------------------------------------------ Figure: APEE clinical results
def fig_apee_results():
    """Clinical (APEE) results from the patent specification (Tables 3 and 4):
    (a) sustain effect (tone-vibration area relative to no-pedal), and
    (b) bFaaaP vs the user's own foot (no significant difference)."""
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(7.6, 3.1))

    # (a) sustain effect: pattern 0 / 1 / 2 (means +/- SD), n = 34
    labels = ["no pedal\n(pat. 0)", "bFaaaP\npat. 1", "bFaaaP\npat. 2"]
    means = [1.00, 1.59, 1.80]; sds = [0.0, 0.32, 0.44]
    fcs = [GREY_F, BLUE_F, GREEN_F]; ecs = [GREY_E, BLUE_E, GREEN_E]
    ax1.bar(range(3), means, yerr=sds, capsize=4, color=fcs, edgecolor=ecs, linewidth=1.3)
    ax1.set_xticks(range(3)); ax1.set_xticklabels(labels, fontsize=8)
    ax1.set_ylabel("relative tone-vibration area")
    ax1.set_title("(a) sustain effect ($n{=}34$)", fontsize=9)
    ax1.set_ylim(0, 2.5)

    def sig(ax, x1, x2, y, txt):
        ax.plot([x1, x1, x2, x2], [y, y + 0.04, y + 0.04, y], color="#333", lw=1)
        ax.text((x1 + x2) / 2, y + 0.05, txt, ha="center", va="bottom", fontsize=7)
    sig(ax1, 0, 1, 1.95, "$p{<}0.01$")
    sig(ax1, 1, 2, 2.12, "$p{<}0.01$")
    sig(ax1, 0, 2, 2.30, "$p{<}0.01$")
    ax1.grid(axis="y", alpha=0.25)

    # (b) bFaaaP vs own foot (Class I controls): pattern 1 and 2, not significant
    groups = ["pattern 1", "pattern 2"]
    b = [1.59, 1.80]; f = [1.47, 1.70]; bsd = [0.32, 0.44]; fsd = [0.32, 0.44]
    xpos = np.arange(2); w = 0.36
    ax2.bar(xpos - w / 2, b, w, yerr=bsd, capsize=3, color=BLUE_F, edgecolor=BLUE_E,
            linewidth=1.2, label="bFaaaP ($n{=}34$)")
    ax2.bar(xpos + w / 2, f, w, yerr=fsd, capsize=3, color=GREY_F, edgecolor=GREY_E,
            linewidth=1.2, label="own foot ($n{=}9$)")
    ax2.set_xticks(xpos); ax2.set_xticklabels(groups, fontsize=8)
    ax2.set_ylabel("relative tone-vibration area")
    ax2.set_ylim(0, 2.5)
    ax2.set_title("(b) bFaaaP vs. own foot", fontsize=9)
    ax2.text(0, 2.12, "n.s.", ha="center", fontsize=8)
    ax2.text(1, 2.30, "n.s.", ha="center", fontsize=8)
    ax2.legend(fontsize=7.0, loc="lower center")
    ax2.grid(axis="y", alpha=0.25)
    fig.tight_layout()
    save(fig, "fig_apee_results")


# ------------------------------------------------ Figure: APEE test score + pedal patterns
def fig_apee_score():
    """The APEE test score and the two pedalling patterns (reconstruction of the
    patent/PCT score figure, WO2019176164 Fig. 23). The motif do-do-do, re-re-re,
    mi-mi-mi (3/4) is repeated four times. It is played three ways: pattern 0 (no
    pedal), and two bFaaaP pedalling patterns shown as pedal-down spans -- pattern 1
    changes the pedal at each three-note group, pattern 2 holds it across the groups
    for a longer, more connected sustain (hence pattern 2 > pattern 1 in sustain)."""
    fig, ax = plt.subplots(figsize=(7.6, 2.5))
    pitches = {"do": 0, "re": 1, "mi": 2}
    groups = ["do", "re", "mi"]              # three-note groups
    note_w, gap = 0.30, 0.06                 # block width and inter-note gap
    grp_span = 3 * note_w + 2 * gap          # width of a 3-note group
    grp_gap = 0.22                           # silence between groups (pattern-1 lift)
    rep_gap = 0.42                           # gap between the four repetitions
    y_note = {0: 2.55, 1: 2.80, 2: 3.05}     # pitch rows (do/re/mi)
    p1_y, p2_y = 1.85, 1.35                   # pedal-span rows
    x = 2.5                                   # leave room at left for row labels
    ax.set_xlim(0, 15.6); ax.set_ylim(0.7, 3.6); ax.axis("off")
    # pitch row guide labels
    for nm, r in pitches.items():
        ax.text(0.05, y_note[r], nm, ha="left", va="center", fontsize=7, color="#999")
    for rep in range(4):
        rep_x0 = x
        for gi, g in enumerate(groups):
            gx0 = x
            for k in range(3):                # three notes of the group
                ax.add_patch(Rectangle((x, y_note[pitches[g]] - 0.07), note_w, 0.14,
                             facecolor="#333", edgecolor="none"))
                x += note_w + (gap if k < 2 else 0)
            # pattern 1: one span per three-note group (re-pedal at each group)
            ax.add_patch(Rectangle((gx0, p1_y - 0.06), grp_span, 0.12,
                         facecolor=BLUE_E, edgecolor="none"))
            x += grp_gap
        rep_x1 = x - grp_gap
        # pattern 2: one long span across the whole repetition (held across groups)
        ax.add_patch(Rectangle((rep_x0, p2_y - 0.06), rep_x1 - rep_x0, 0.12,
                     facecolor=GREEN_E, edgecolor="none"))
        x += rep_gap
    ax.text(x + 0.05, (y_note[0] + y_note[2]) / 2, "...", fontsize=10, va="center")
    # row labels on the right
    ax.text(0.05, p1_y, "Pedal pattern 1", ha="left", va="center", fontsize=7.6, color=BLUE_E)
    ax.text(0.05, p2_y, "Pedal pattern 2", ha="left", va="center", fontsize=7.6, color=GREEN_E)
    ax.text(0.05, 3.42, "motif (3/4): do do do | re re re | mi mi mi  -- repeated 4x",
            ha="left", va="center", fontsize=7.6, color="#444")
    ax.annotate("re-pedal each group", (3.01, p1_y - 0.10), (3.4, p1_y - 0.52),
                fontsize=6.6, color=BLUE_E, ha="center",
                arrowprops=dict(arrowstyle="->", color=BLUE_E, lw=0.8))
    ax.annotate("held across groups", (4.25, p2_y - 0.10), (5.6, p2_y - 0.42),
                fontsize=6.6, color=GREEN_E, ha="center",
                arrowprops=dict(arrowstyle="->", color=GREEN_E, lw=0.8))
    ax.set_title("APEE test score and the two pedalling patterns", fontsize=9.5)
    save(fig, "fig_apee_score")


# ------------------------------------------------ Figure: TVA ratio method
def fig_tva_method():
    """How the sustain score is computed: the tone-vibration area (TVA) ratio.
    The same motif is recorded three ways; each waveform's area is measured
    (Sonic Visualiser -> ImageJ). The no-pedal area TVA0 is set to 1.00 and each
    bFaaaP pattern's score is TVA_n / TVA0. More sustain -> larger area. The panel
    waveforms are schematic; the ratios (1.00, 1.59, 1.80) are the measured APEE
    study means (patent JP6726319, Table 3)."""
    fs = 3000.0
    onset, n = 0.40, 9                                    # 9-note motif
    pitches = [262, 262, 262, 294, 294, 294, 330, 330, 330]
    T = onset * n + 0.8
    t = np.linspace(0, T, int(T * fs))

    def wave(decay):                                     # additive damped sines
        y = np.zeros_like(t)
        for i, f0 in enumerate(pitches):
            t0 = i * onset
            m = t >= t0
            y[m] += np.exp(-decay * (t[m] - t0)) * np.sin(2 * np.pi * f0 * (t[m] - t0))
        return y

    panels = [("TVA$_0$  (no pedal)", 11.0, GREY_E, GREY_F, 1.00),
              ("TVA$_1$  (pattern 1)", 3.3, BLUE_E, BLUE_F, 1.59),
              ("TVA$_2$  (pattern 2)", 2.1, GREEN_E, GREEN_F, 1.80)]
    waves = [wave(d) for _, d, _, _, _ in panels]
    gmax = max(np.abs(w).max() for w in waves)

    fig = plt.figure(figsize=(7.9, 3.7))
    gs = fig.add_gridspec(2, 3, height_ratios=[3.0, 1.0], hspace=0.6, wspace=0.18)
    for j, ((lab, _, ec, fc, ratio), w) in enumerate(zip(panels, waves)):
        ax = fig.add_subplot(gs[0, j])
        wn = w / gmax
        ax.plot(t, wn, color=ec, lw=0.4)
        ax.fill_between(t, np.abs(wn), color=fc, alpha=0.55, lw=0)   # the "area" (TVA)
        ax.set_xlim(0, T); ax.set_ylim(-1.08, 1.08)
        for s in ax.spines.values():
            s.set_edgecolor("#333"); s.set_linewidth(1.0)
        # title carries the panel name + its relative area
        ax.set_title(f"{lab}\narea = {ratio:.2f}", fontsize=9.2, color=ec)
        # axes: amplitude (A.U.) is the y scale; time is relative (recording tempo
        # is not in the study data), shown as an arrow with no fabricated ms values.
        ax.set_xticks([])
        ax.set_xlabel("Time (a.u.) " + r"$\rightarrow$", fontsize=8.6)
        ax.set_yticks([-1, 0, 1])
        if j == 0:
            ax.set_ylabel("Amplitude (A.U.)", fontsize=8.6)
            ax.tick_params(axis="y", labelsize=8.0)
        else:
            ax.set_yticklabels([])
    axf = fig.add_subplot(gs[1, :]); axf.axis("off")
    axf.text(0.5, 0.74, "TVA = tone-vibration area (shaded). "
             r"TVA$_0\equiv1.00$;  score = TVA$_n$ / TVA$_0$.",
             ha="center", va="center", fontsize=9.6)
    axf.text(0.5, 0.18, "Measured APEE means: TVA$_0$ = 1.00,  "
             "TVA$_1$/TVA$_0$ = 1.59,  TVA$_2$/TVA$_0$ = 1.80",
             ha="center", va="center", fontsize=9.0, color="#333")
    fig.suptitle("Computing the sustain score from the tone-vibration area (TVA)",
                 fontsize=10.2, y=1.0)
    save(fig, "fig_tva_method")


# ------------------------------------------------ Figure: APEE pipeline (big picture)
def fig_apee_pipeline():
    """End-to-end overview of the APEE method: from the test score and its two
    pedalling patterns, through recording each take, to measuring the waveform
    tone-vibration area (TVA), normalising, taking the ratio, and the result.
    Redesigned for readability: taller boxes, larger fonts, minimal text per box
    (details live in the caption and the dedicated figures)."""
    fig, ax = plt.subplots(figsize=(9.9, 3.9))
    ax.set_xlim(0, 104); ax.set_ylim(0, 40); ax.axis("off")
    W, H, Y0, SP = 18.0, 32.0, 3.5, 21.0
    x0 = [1 + i * SP for i in range(5)]
    titles = ["1. Score +\n2 patterns", "2. Record\n3 takes",
              "3. Measure\narea (TVA)", "4. Normalise\n& ratio", "5. Result"]
    for x, t in zip(x0, titles):
        ax.add_patch(FancyBboxPatch((x, Y0), W, H, boxstyle="round,pad=0.3,rounding_size=1.4",
                     linewidth=1.5, edgecolor=BLUE_E, facecolor=BLUE_F))
        ax.text(x + W / 2, Y0 + H - 1.6, t, ha="center", va="top", fontsize=10.5, fontweight="bold")
    for x in x0[:-1]:
        ax.add_patch(FancyArrowPatch((x + W, Y0 + H / 2), (x + SP, Y0 + H / 2),
                     arrowstyle="-|>", mutation_scale=18, lw=2.1, color="#333"))

    # Stage 1: the three pedalling patterns as mini pedal-down rows (P0/P1/P2)
    rows = [("P0", GREY_E, "none"), ("P1", BLUE_E, "seg3"), ("P2", GREEN_E, "long")]
    for i, (lab, col, kind) in enumerate(rows):
        ry = Y0 + 21 - i * 5.0
        ax.text(x0[0] + 2.5, ry, lab, ha="left", va="center", fontsize=9.0,
                fontweight="bold", color=col)
        bx = x0[0] + 7.0; span = 9.5
        if kind == "none":
            ax.plot([bx, bx + span], [ry, ry], color=col, ls=":", lw=1.5)
        elif kind == "seg3":
            for k in range(3):
                ax.add_patch(Rectangle((bx + k * (span / 3), ry - 0.8), span / 3 * 0.8, 1.6,
                             facecolor=col, edgecolor="none"))
        else:
            ax.add_patch(Rectangle((bx, ry - 0.8), span, 1.6, facecolor=col, edgecolor="none"))
    ax.text(x0[0] + W / 2, Y0 + 3.2, "P1 re-pedals · P2 holds", ha="center", va="center",
            fontsize=7.6, color="#555")

    # Stage 2: record three takes
    ax.text(x0[1] + W / 2, Y0 + H - 8.5, "play and record\neach pattern\n(iPhone, .wav)",
            ha="center", va="top", fontsize=9.0)
    ax.text(x0[1] + W / 2, Y0 + 6.5, "3 takes:\nP0 · P1 · P2", ha="center", va="center",
            fontsize=8.6)

    # Stage 3: a decaying waveform with shaded (rectified) area = TVA
    sx0 = x0[2] + 2.5; sw = W - 5.0; sb = Y0 + 19.0; sh = 6.5
    tt = np.linspace(0, 1, 320)
    amp = np.exp(-2.3 * tt) * np.sin(2 * np.pi * 9 * tt)
    xs = sx0 + sw * tt
    ax.fill_between(xs, sb, sb + sh * np.abs(amp), color=BLUE_F, lw=0)
    ax.plot(xs, sb + sh * amp * 0.5, color=BLUE_E, lw=0.6)
    ax.text(x0[2] + W / 2, Y0 + 14.0, "tone-vibration\narea (TVA)", ha="center", va="top", fontsize=8.8)
    ax.text(x0[2] + W / 2, Y0 + 6.5, "Sonic Visualiser\n→ ImageJ", ha="center", va="top", fontsize=7.8)

    # Stage 4: the formula
    ax.text(x0[3] + W / 2, Y0 + 21, "TVA$_0 \\equiv 1.00$", ha="center", va="center", fontsize=10.0)
    ax.text(x0[3] + W / 2, Y0 + 12, "score =\nTVA$_n$ / TVA$_0$", ha="center", va="center", fontsize=10.0)

    # Stage 5: mini result bar chart + significance
    bb = Y0 + 8.5; bscale = 12.0; bw = 2.9; bgap = 1.9
    res = [("P0", 1.00, GREY_F, GREY_E), ("P1", 1.59, BLUE_F, BLUE_E), ("P2", 1.80, GREEN_F, GREEN_E)]
    bx0 = x0[4] + 3.2
    for i, (lab, v, fc, ec) in enumerate(res):
        bx = bx0 + i * (bw + bgap)
        ax.add_patch(Rectangle((bx, bb), bw, v / 1.80 * bscale, facecolor=fc, edgecolor=ec, lw=1.1))
        ax.text(bx + bw / 2, bb - 1.2, lab, ha="center", va="top", fontsize=7.6)
        ax.text(bx + bw / 2, bb + v / 1.80 * bscale + 0.5, f"{v:.2f}", ha="center", va="bottom", fontsize=7.2)
    ax.text(x0[4] + W / 2, Y0 + H - 8.0, "relative sustain", ha="center", va="top", fontsize=8.0)
    ax.text(x0[4] + W / 2, Y0 + 3.2, "$p<0.01$ · $\\approx$ own foot", ha="center", va="center", fontsize=7.4)

    fig.suptitle("The APEE pipeline: from score and pedalling patterns to a quantitative sustain score",
                 fontsize=10.5, y=1.0)
    save(fig, "fig_apee_pipeline")


if __name__ == "__main__":
    fig_overview()
    fig_architecture()
    fig_control()
    fig_rate_decoupling()
    fig_pro_mechanism()
    fig_control_vs_priorart()
    fig_apee_results()
    fig_apee_score()
    fig_tva_method()
    fig_apee_pipeline()
    print("done.")
