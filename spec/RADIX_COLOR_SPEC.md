# Radix Color Generation Specification

## Overview

This specification documents the comprehensive technical breakdown of the Radix Color Generation Workflow. The system generates perceptually uniform, contextually aware 12-step color scales from user-provided accent, gray, and background colors.

## 🌈 The 5-Step Radix Color Generation Workflow (Technical Deep Dive)

### 1. ⚙️ Preparation: Conversion to OKLCH (The Control Problem)

The process initializes by converting all input colors (the $\text{accent}$, $\text{gray}$, and $\text{background}$ colors) from their sRGB hex strings into the **OKLCH** color space.

* **The Problem: Inaccurate Perception** 🎨

    Standard color spaces like sRGB are not *perceptually uniform*. This means equal steps in an RGB value do not correspond to equal steps in perceived brightness or saturation.

* **The Solution: Perceptual Uniformity** ✅

    OKLCH separates color into three coordinates that align closely with human vision: $L$ (Lightness), $C$ (Chroma/saturation), and $H$ (Hue). This provides **precise control** to manipulate the lightness progression without corrupting the color's hue or saturation.

---

### 2. 🧮 Scale Selection and Blending (The Quality Problem)

The goal is to create a high-quality lightness curve progression that a simple algorithm can't easily reproduce.

* **The Problem: Generating the Perfect Curve** 📉

    Relying only on a simple mathematical formula to generate 12 steps often results in a visually dull or uneven lightness curve.

* **The Solution: Interpolation with Templates** 🧬

    The code finds the **two closest predefined Radix scales** (templates) by iterating through the color library and measuring the difference using the **$\Delta E_{OK}$** (delta E OKLCH) color difference metric.

    It then uses **trigonometry** (cosine and tangent ratios) to determine the precise proportional blending $\text{ratio}$ between these two templates (A and B). This creates a bespoke 12-step scale that lies exactly along the color trajectory of the user's input, combining the visual quality of the hand-tuned templates.

---

### 3. 🎯 Chroma and Hue Correction (The Identity Problem)

After blending, the template has a great progression, but its color identity (hue and saturation) is just an average.

* **The Problem: Color Drift** 🌊

    The blending process averages the $\text{Hue}$ ($H$) and $\text{Chroma}$ ($C$) of the two reference scales. The resulting scale is an approximation and might be slightly $\text{off-hue}$ or have the wrong overall saturation compared to the user's input.

* **The Solution: Force the Color Identity** 🔒

    The code explicitly overrides the $\text{Hue}$ and scales the $\text{Chroma}$ of the blended template to perfectly match the user's seed color.

    1.  The $\text{Hue}$ ($H$) of the seed color is assigned directly to all 12 steps.

    2.  The $\text{Chroma}$ ($C$) of every step is scaled by the $\text{ratio} \ C$, calculated as the ratio of the seed color's $\text{Chroma}$ to the blended base color's $\text{Chroma}$.

    This ensures the scale has the optimal progression but the unmistakable $\text{Hue}$ and saturation of the original input:

    $$\text{Chroma}^{\text{final}}_{i} = \text{Chroma}^{\text{blended}}_{i} \times \left( \frac{\text{Chroma}_{\text{seed}}}{\text{Chroma}_{\text{base}}} \right)$$

---

### 4. 🎚️ Lightness Curve Transposition (The Context Problem)

The generated scale must maintain its functional contrast when placed on any background color, not just a default one.

* **The Problem: Fixed Contrast** 🧱

    The low-contrast steps ($L_1$, $L_2$) are highly sensitive to background changes. If the $\text{background}$ is much lighter or darker, these steps can lose their intended subtle difference.

* **The Solution: Guarantee Relative Contrast** 🔗

    The algorithm **transposes** the entire lightness ($L$) curve to anchor it to the user's $\text{background}$. It calculates the lightness $\text{diff}$ between the background and the first step's lightness:

    $$\text{diff} = L_{\text{step\_1}} - L_{\text{background}}$$

    This $\text{diff}$ is then applied across the entire scale using the `transposeProgressionStart` function, which utilizes a **Bezier easing function** (e.g., $\text{[0, 2, 0, 2]}$ for light mode) to non-linearly distribute the shift:

    $$L^{\text{final}}_{i} = L^{\text{template}}_{i} - \text{diff} \times \text{BezierEase}(i)$$

---

### 5. 📦 Final Output and Alpha Calculation (The Transparency Problem)

The final step generates the two transparent scale formats (`scaleAlpha` and `scaleAlphaWideGamut`).

* **The Problem: Inconsistent Transparency** 👻

    Standard CSS opacity is relative and visually unpredictable. The transparent steps ($\text{a1-a12}$) must always look correct *as if* they were the regular steps faded onto the user's specific $\text{background}$.

* **The Solution: Pre-Blended Alpha Colors** 💻

    The code uses the `getAlphaColor` function to perform **reverse alpha blending**. It algebraically solves for an opaque $\text{Foreground}$ color and an $\text{Alpha}$ value ($\alpha$) that, when layered over the user-defined $\text{background}$, results in the desired $\text{Target}$ color (the corresponding step from the opaque scale).

    The function reverses the standard blending equation to solve for the $\text{Foreground}$ color and $\alpha$:

    $$\text{Target} = \text{Background} \times (1 - \alpha) + \text{Foreground} \times \alpha$$

    The output is a single hex or P3 string with an alpha channel (e.g., `#RRGGBBAA`), which locks the visual blend for absolute consistency across the UI.

---

## Summary

This framework allows a single input color to generate a robust, perceptually optimized, and contextually aware 12-step palette. The workflow combines:

- **Perceptual uniformity** through OKLCH color space
- **Visual quality** through template interpolation
- **Color identity preservation** through hue and chroma correction
- **Contextual adaptation** through lightness curve transposition
- **Consistent transparency** through reverse alpha blending
