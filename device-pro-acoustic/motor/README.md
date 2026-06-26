# Motor

> ⚠️ **Availability (EOL):** the original **IQ Motion Control / Fortiq** smart
> motor is **no longer easily available** — the project's own firmware notes the
> *IQ motor supply stopped*, and the latest design moved to a **closed‑loop
> stepper**. IQ Motion Control now operates as **Vertiq**. For currently‑available
> replacements and how to adapt the firmware, see
> [`../HARDWARE-AVAILABILITY.md`](../HARDWARE-AVAILABILITY.md).

The pedal was originally driven by an **IQ Motion Control / Fortiq** servo motor
module, commanded from the Pico firmware via the IQ module communication library
(`../firmware/libraries/iq-module-communication-arduino/`). This applies to the
**v039B** firmware only; the latest **v052B** firmware targets a closed‑loop
stepper instead.

## What you need

- **Original (EOL):** **IQ‑FORTIQ‑M42BLS‑100** (IQ motor, 100 W; ≈¥33,000 on
  Crowd Supply) speaking the IQ serial protocol — only if you can still source one.
- **Recommended (current):** a closed‑loop stepper. The team prototyped the
  stepper path with a **DRV8825** STEP/DIR driver; an integrated option is the
  **MKS SERVO42C/D** (NEMA17). The motor drives a **GT-2 timing belt → T10 lead
  screw → push‑rod**. See [`../HARDWARE-AVAILABILITY.md`](../HARDWARE-AVAILABILITY.md).

## Documentation (third-party — not redistributed)

The motor datasheets are **vendor copyright** and are intentionally **not
included** in this repository. Obtain them from the manufacturer:

- IQ Motion Control / **Vertiq** — <https://iqmotion.readthedocs.io/> (docs/SDK),
  <https://www.iq-control.com/>

The reference materials used during development were:
`Fortiq42_Module_Datasheet.pdf`, `fortiq_datasheet.pdf`, and `iq_doc_v1_1`…`v1_6.pdf`
(kept privately in `bFaaaP_成澤_20260608/IQ_motr_doc/`, not for republication).

> If you have written permission to redistribute any vendor document, add it here
> with the appropriate attribution; otherwise link to the official source only.
