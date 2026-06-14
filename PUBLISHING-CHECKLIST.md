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
- [ ] `device-pro-acoustic/firmware/libraries/iq-module-communication-arduino/` —
      keep its original `LICENSE`/attribution intact; verify redistribution is allowed.
- [ ] `device-pro-acoustic/hardware/schematic/` — the circuit schematic + block /
      power diagrams are by **Reo Taguchi** (github.com/reodon), imported from
      `reodon/copy_bfaaap_pro`, which has **no license file**. **Get Taguchi's
      consent and a license** before public release; ideally also obtain the
      **KiCad source** (only a PNG export is available; reportedly in Discord).
- [x] `device-pro-acoustic/hardware/cad/from-discord-2025/` and
      `3d-print/from-discord-2025/` — CAD/STL shared by **H. Narusawa** in the team
      **Discord**. **Narusawa consented (2026-06-14)** to co-authorship, GitHub name
      credit, and including this CAD. *(A project license still needs to be chosen
      before publishing — see §4.)*
- [ ] `device-pro-acoustic/hardware/PARTS-REFERENCE.md` + `hardware/reference/` —
      adapted from `TomoShishido/bfaaapteam` (`docs/hardware.md`); confirm that
      repo's content can be reused publicly. `DISCORD-FINDINGS.md` summarizes a
      **private Discord**; build photos/videos are **kept out** of the repo.

## 4. Project license & patents

- [ ] Choose and add the project `LICENSE` (see the placeholder file).
      Suggested: software MIT/Apache-2.0, hardware CERN-OHL or CC-BY-SA-4.0.
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

- [ ] `git init`, review `git status` against `.gitignore`, commit, and only then
      create the public remote.
