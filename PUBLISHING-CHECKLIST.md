# Publishing checklist — review BEFORE making this repository public

This folder is staged for open-source release. Work through every item below
before pushing to a public GitHub repository.

## 1. Secrets & credentials (CRITICAL)

- [ ] **App Store Connect API key** — the file `temp_info/AuthKey_<KeyID>.p8`
      and the Key ID / Issuer ID noted in the parent `CLAUDE.md` are **secrets**.
      They live OUTSIDE this folder; make sure they are never copied in.
      **Revoke** the key in App Store Connect once upload work is finished
      (Users and Access → Integrations).
- [ ] Confirm no `*.p8`, `*.mobileprovision`, `*.p12`, `*.cer`, provisioning
      profiles, or signing certificates are inside `github_opensource/`.
      (`.gitignore` blocks these; the iOS source in `ios-app/src/` was imported
      with signing data removed — verify.)
- [ ] The internal `CLAUDE.md`, `temp_info/`, and `*.zip` archives in the parent
      directory are **not** part of this folder and must not be published.

## 2. Personal information (PII)

- [ ] `device-pro-acoustic/assembly/` — the original `readme.pdf` may contain
      names/addresses/contact details. Review and redact before including.
- [ ] `device-pro-acoustic/hardware/enclosure-labels/` — the product label
      (`*.odt`) may contain personal/branding info. Not yet copied in; review first.
- [ ] Author attribution: per decision, author names in source/CAD headers are
      **kept** as credit. (`ios-app/src/` keeps `Created by …` headers.)
- [ ] `ios-app/src/` was sanitized: `DEVELOPMENT_TEAM` blanked, bundle ID set to
      placeholder `com.example.bfaaap`, `xcuserdata`/secrets removed — verify.
- [ ] `docs/members/` uses public caricatures from bfaaap.com; **personal contact
      details** (phone/email from the source pages) were **omitted** — confirm none
      slipped in. Get member consent for including their portrait/bio.
- [ ] `ios-app/app-store/` & `docs/media/` use the project's own public assets
      (App Store screenshots, concert thumbnails, poster). Confirm reuse is intended.

## 3. Third-party licensing

- [ ] `device-pro-acoustic/motor/` — IQ / Fortiq datasheets are **vendor
      copyright**, intentionally **not redistributed** (referenced only). Keep it so.
- [x] **ROHM `RU1J002YN` MOSFET datasheet** (Switch) — vendor copyright (© ROHM).
      Narusawa shared the PDF privately (2026-06-24); it is **kept out of the repo**
      and **referenced by link only** (docs link to the official ROHM product page).
- [ ] `device-pro-acoustic/firmware/libraries/iq-module-communication-arduino/` —
      keep its original `LICENSE`/attribution intact; verify redistribution is allowed.
- [x] `device-pro-acoustic/hardware/schematic/` — the circuit schematic + block /
      power diagrams are by **Taguchi** (github.com/reodon), imported from
      `reodon/copy_bfaaap_pro`, which had **no license file**. **Taguchi consented
      (2026-06-18)** and agreed to waive rights to the maximum extent → released
      under the hardware layer (**CERN-OHL-W-2.0**). **KiCad source delivered by
      Taguchi (2026-06-24)** and **imported** to `hardware/schematic/kicad/`
      (`.kicad_sch` authoritative; `.kicad_pcb` empty stub) — scanned clean of
      absolute paths / PII before committing.
- [x] `device-pro-acoustic/hardware/cad/from-discord-2025/` and
      `3d-print/from-discord-2025/` — CAD/STL shared by **H. Narusawa** in the team
      **Discord**. **Narusawa consented (2026-06-14)** to co-authorship, GitHub name
      credit, and including this CAD. *(A project license still needs to be chosen
      before publishing — see §4.)*
- [x] `device-pro-acoustic/hardware/photos/` — build photos (airback + drive unit)
      by **Taguchi** from the Discord. **Taguchi (photographer) consented
      (2026-06-18)** (no people/PII shown).
- [x] `device-pro-acoustic/hardware/PARTS-REFERENCE.md` + `hardware/reference/` —
      parts **data** adapted from `TomoShishido/bfaaapteam` (`docs/hardware.md`, by
      consented co-authors Taguchi & Narusawa). `DISCORD-FINDINGS.md` summarizes a
      **private Discord**; build photos/videos are **kept out** of the repo.
      ✅ **Image provenance resolved (2026-06-24):** Taguchi flagged that the two
      images in the legacy `docs/hardware.md` (`rpi_pico/pinout.svg`,
      `fortiq42/electrical-interface.png`) were brought in from elsewhere with
      **unknown license**. Both were **removed** and **replaced with original
      bFaaaP-project matplotlib drawings** (`pico_pinout_bfaaap.png`,
      `fortiq42_interface_bfaaap.png`, CC BY 4.0) plus links to the official
      Raspberry Pi / Vertiq sources. No third-party images of uncertain license remain.
      ✅ **Likely original sources confirmed by Taguchi (2026-06-25):** the Pico image
      most likely came from the **Raspberry Pi Pico documentation / datasheet**
      (RP2040-based board) and the motor image from the **Fortiq BLS42 datasheet**
      (`fortiq_datasheet.pdf`) — i.e. **vendor copyright** (© Raspberry Pi Ltd / © IQ
      Motion Control). This confirms removing-and-redrawing was the correct call; we
      redistribute no vendor image and only **link** to those official sources.

## 4. Project license & patents

- [x] Project `LICENSE` **adopted** (2026-06-18): software → **Apache-2.0** (explicit
      patent grant), hardware → **CERN-OHL-W-2.0**, documentation → **CC-BY-4.0**.
      Full, verbatim texts added under [`LICENSES/`](LICENSES/) (Apache-2.0,
      CERN-OHL-W-2.0, CC-BY-4.0); top-level `LICENSE` records the layer split,
      patents, contributor consent, and third-party components.
- [ ] **Patent decision (important).** The control method is patented in Japan —
      **JP 6726319 B2** (Auxiliary pedal system) and **JP 7004771 B2** (Device
      controller); priority‑basis PCT **WO 2019/176164**. Policy (in README/LICENSE):
      licensing depends on the embodiment, but **public/open‑purpose uses can be
      licensed free of charge**; in particular, **products/services that enable
      inclusive social participation for people with disabilities — even paid /
      commercial ones — are licensed free of charge as a matter of policy.**
      **Contact T. Shishido.** For the software license, prefer one **with an
      explicit patent grant (Apache‑2.0)**; MIT has none.

## 5. Content to populate / decide

- [x] iOS source vendored into `ios-app/src/` (sanitized, buildable with your own team).
- [ ] Fill `device-pro-acoustic/assembly/` with the real build guide + sourced BOM.
- [ ] Add airback details (dimensions, pump/controller schematic, photos) to
      `device-pro-acoustic/hardware/airback/`.
- [ ] Add firmware wiring/pin docs and recommended 3D‑print settings.
- [ ] Confirm `hardware/3d-print/` meshes match the latest CAD revision.
- [ ] Populate `device-switch-electronic/` when that line is ready.

## 6. Localization

- [ ] Docs are **English‑first**. After approval, create Japanese and German
      versions in separate `i18n/ja/` and `i18n/de/` subfolders.

## 7. Final

- [x] **Git history purge — DONE (2026-06-24).** The private peer-review / TACCESS files (an arXiv-version split kept
      separate) were stripped from **all** history with
      `git-filter-repo`, `main` was **force-pushed**, and the obsolete
      `feature/docs-overhaul` + `feature/i18n-reference-docs` remote branches (which
      still carried the old history) were **deleted**. Verified: gone from
      `origin/main` history, 0 sensitive objects, working content unchanged. A
      private backup bundle exists outside the repo — **delete it before going
      public**. For absolute certainty, ask **GitHub Support to expire unreachable
      objects** before flipping the repo to public (do NOT delete/recreate the repo —
      it holds the AI-support Discussions).
- [ ] Working tree is on the existing private remote; review `git status` against
      `.gitignore`, then change repository visibility to **public** (final step).
