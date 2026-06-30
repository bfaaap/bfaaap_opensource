# Pending supplements — content to add before publication

> Working tracker (started 2026-06-30, Plan §21 in the private `CLAUDE.md`).
> Items here are **deliberately not finalized yet** because they depend on
> information still in flight (team review, member messages, external partners).
> Resolve every item before flipping the repository public.
> This file is internal working state; remove or fold into `PUBLISHING-CHECKLIST.md`
> at release.

## A. Device finalization (gates "device creation complete")

- [ ] **Pro — New Generation / successor motor (Tanaka draft + Narusawa feedback).**
      Tanaka is deepening the "New Generation Model" draft and will share via LINE;
      Narusawa's impressions on it close out the substantive device-build work.
      Until then, keep the current draft framing ("original = IQ/Fortiq M42BLS, **EOL**;
      successor = closed-loop NEMA-17 class, **under evaluation**"). Do **not** hard-code
      final part numbers, pinout, or firmware values for the successor across README /
      build/pro / device-pro-acoustic / arXiv / TACCESS.
      - On finalize: update README BOM, `docs/build/pro.md`, `device-pro-acoustic/**`,
        `HARDWARE-AVAILABILITY.md`, motor firmware draft, and both papers consistently.
- [ ] **Pro — airback / air-pump drive (electric GP12 → 2SK4017 vs WINBAG manual) and
      HX711 retain/remove** — depends on the successor decision above. Keep current text;
      do not delete HX711/2SK4017/24V references until confirmed.

## B. People / messages / partners (consent-gated)

- [ ] **Yamaguchi banner permission** — to be granted at tomorrow's lesson. Banner
      illustrations are staged locally (`docs/media/illustrations/studio*-banner-*.png`).
      Do not publish the banner publicly until permission is confirmed.
- [ ] **New member additions** (e.g. Nagasawa Keiko portrait/avatar staged) — confirm
      consent + display-name rules before publishing in members/story.
- [ ] **External partner message** — Tokyo Women's Choral Society (currently being
      approached). Add their message / acknowledgement once received and approved.
- [ ] **Additional member messages** (`member_messages/`, private staging) — weave into
      members / voices / story / support pages with consent and display-name rules.
- [ ] **Voices** — overview `docs/voices.md` (EN, 9 members incl. Tanaka, Shishido first) + subfolder
      **`docs/voices/<slug>.md`** = each member's **verbatim original (JA) + mirror translation (EN)**
      (ported from `member_messages/`, internal frontmatter stripped). Overview links to each full file.
      TODO: (a) add `i18n/ja/docs/voices.md` + `i18n/de/docs/voices.md` overview mirrors in P3 (the
      per-member full files are already bilingual, so they can be shared); (b) **append more voices as
      they arrive** (one overview section + one `voices/<slug>.md` per member); (c) `voices/shishido.md`
      **withholds the non-member name "Yoshida"** pending consent — restore only if he consents.
- [ ] **P4 member-bio check** — when updating bfaaap.com / saaipf.com, confirm Fati is shown as
      **holding a Ph.D.** (not "doctoral course") and Tokushige as **Patent Engineer** (not Patent
      Attorney). (2026-06-30 grep found neither bio present on those sites; re-verify in P4.)
- [ ] **P4 APEE-table check** — when updating bfaaap.com / saaipf.com, if the APEE participant table or
      offset/multiplier ranges are shown, use the corrected values (mult: I 10–40, II 20–30, III 8–50;
      offset I 5–19°/II 5°/III 3–10°; span offset 3–19°/mult 8–50), not the old I 15–40 / III 30–50.
      (2026-07-01 grep: not currently on either site; instruction recorded in both sites' CLAUDE.md.)
- [ ] **Non-member name "Yoshida"** appears in Shishido's origin story draft — confirm
      consent (or anonymize) before that text is published.

## B2. Papers (arXiv + TACCESS) — RESOLVED (flow review, 2026-07-01)

> BOM update, Future-perspectives (Narusawa), Taguchi→Acknowledgements, safe
> consistency fixes, and the author's three decisions are all DONE; both papers
> recompile clean (arXiv 27 pp / TACCESS 23 pp, 0 errors, 0 undefined refs).

- [x] **Offset/multiplier headline (3–10° / 10–50).** KEPT as-is per author — it is the
      actual movable range / a specific set of participants' choices; Table 1 carries the
      full as-used span.
- [x] **Table 1 reconciled with Table 9 (appendix, all 46 recordings).** The *row*
      multipliers were wrong, not the caption: Class I 15→**10**–40, Class III 30→**8**–50;
      Class II 20–30 and all offsets (I 5–19, II 5, III 3–10) confirmed correct. Overall
      span back to **multiplier 8–50 / offset 3–19** (caption). (Headline 10–50/3–10° kept
      per author as the recommended operating range.)
- [x] **Concert year** set to **2018–2025** (matches the latest cited event).
- [ ] *(optional, pre-existing, not addressed)* survey-table fractional counts (4.5/7.5
      = split responses?) and Eurovent year (2002 data vs 2005 cite) — author may leave.
- [ ] Separate, still open: **arXiv submission** itself (finalize license/patent-grant,
      upload LaTeX source, add arXiv ID/DOI) — see memory [[arxiv-paper-submission]].

## B3. P3 — JA/DE GitHub site (DONE 2026-07-01)

- [x] EN finalized (control-law wording → offset+multiplier→response-speed everywhere; eyes-free
      reworded; 65→50 mm; operation numbering; README successor=NEMA17 / frame 2040·2080·4040).
- [x] Propagated to existing JA/DE; full i18n control-law re-scan = 0 old framing.
- [x] Translated 6 new docs to JA + DE: voices.md, ai-team-live.md, ai-support-example-pro-motor.md,
      references/README.md, ai-support/threads/README.md, docs/README.md. Switchers live; Voices added
      to JA/DE README nav + JA/DE ai-support cross-refs.
- [x] **EN/JA/DE parity** (26 = 26 translatable docs) · **full-repo link check 0 broken (1575 links)**.
- [ ] **Remaining small P1 EN device-doc cleanups** (non-translated docs, settled, low priority):
      device-pro-acoustic/README.md drop "(planned)" for Switch; airback/README.md + hardware/README.md
      reword manual-bulb→electric-pump-is-the-built-device; firmware/DESIGN-HIGHLIGHTS.md note slider on
      ADC0/GP26 (firmware A3 = to-fix); assembly/README.md drop "(via RJ45)"; 3d-print printer/slicer
      reconcile (QIDI X-Plus4 authoritative).

## C. Payments / external services

- [ ] **Stripe** (Shishido & Associates) — under review; once approved add the live
      Payment Link (card / Apple Pay / Google Pay) to `SUPPORT.md` (en/ja/de).

## D. Pre-public gate (from PUBLISHING-CHECKLIST §7 / CLAUDE.md §13)

- [ ] Delete `prepurge-backup.bundle` (outside repo) + ask GitHub Support to expire
      unreachable objects (do **not** delete/recreate the repo — Discussions live there).
- [ ] Final `git status` vs `.gitignore`, then flip visibility to public.

## P1 verification findings — deferred (recorded, not yet fixed)

> Items the English re-verification (Plan §21 P1) surfaced that are blocked on the
> above rather than being a settled fix. Appended as found.

<!-- (P1 fills this in) -->
