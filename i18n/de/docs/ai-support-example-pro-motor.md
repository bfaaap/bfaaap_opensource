# 🧵 Ein Live‑Beispiel: „Welcher Motor kann den abgekündigten (EOL) ersetzen?"

> 🌐 [English](../../../docs/ai-support-example-pro-motor.md) · [日本語](../../ja/docs/ai-support-example-pro-motor.md) · **Deutsch**
>
> Teil von [KI‑gestütztem Support](ai-support.md). Diese Seite zeigt, **wie es sich tatsächlich anfühlt**:
> Die **KI schlägt eine Idee aus den offenen Daten vor, und das echte bFaaaP‑Team prüft und
> ergänzt sie.** Niemand kennt hier die eine „richtige" Antwort — genau deshalb ist die
> menschliche Prüfung wichtig, und genau deshalb macht es Spaß zuzusehen, wie die Antwort Gestalt annimmt.

Der ursprüngliche Antriebsmotor des Pro (**IQ Fortiq M42BLS**) ist **abgekündigt (End‑of‑Life)**. Ein Neuling fragte sinngemäß: *„Welchen Motor + welche Firmware kann ich heute tatsächlich verwenden, um den Pro nachzubauen?"* Es gibt **noch keine feststehende Antwort** — also hat die KI die Vorarbeit aus aktuellen Daten geleistet, und die Leute, die bFaaaP tatsächlich gebaut haben, bringen sich ein. Hier ist dieser Thread.

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/ai.png" width="104" alt="Avatar des KI‑Assistenten"></td>
<td valign="top">

**🤖 KI‑Assistent** &nbsp;·&nbsp; <sub>Entwurfsidee aus aktuellen Webdaten (Juni 2026) — *ungeprüft*</sub>

Hier ein **Ausgangspunkt**, kein Urteil. Das Schwierige ist nicht der Motorkörper (ein gleich großer **NEMA17 / „17er"‑Stepper, STEP/DIR** verwendet den vorhandenen Rahmen, den Riemen und die T10‑Spindel weiter) — es ist die **Kraftrückmeldung**. Der alte IQ‑Servo las seine **Motorleistung** aus, um „zu drücken, bis die Reaktionskraft ansteigt". Ein einfacher Stepper kann das nicht, also müssen wir das *wiederherstellen*. Drei Wege, die ich gefunden habe:

- **A — Closed‑Loop‑Treiber** (Encoder meldet Last): NEMA17 + **MKS SERVO42C/D**, **BTT S42B/S42C** oder **StepperOnline CL42T** + ein Closed‑Loop‑NEMA17. → *Am nächsten am IQ‑Modell „Position anfahren, halten, Last lesen"; STEP/DIR **und** UART/CAN; Open Source (MKS, BTT).*
- **B — Sensorlose Last** (StallGuard): einfacher NEMA17 + **TMC2209**. → *Am günstigsten (~5 $); erkennt „gedrückt/Blockade" über UART — aber ein **relativer** Lastwert, keine absolute Kraft.*
- **C — Direkter Kraftsensor**: einfacher NEMA17 + **DRV8825/A4988** + eine **Wägezelle, ausgelesen vom HX711, der bereits in der Stückliste steht**. → *Misst die echte Andruckkraft; verwendet ein vorhandenes Teil wieder; DRV8825 ist das, was das Team zuerst als Prototyp gebaut hat.*

**Grobe Auslegung (bitte prüfen):** Über die **T10‑Spindel (16 mm/U Steigung, 1:1‑Riemen)** ergibt das Haltemoment *T* eines NEMA17 eine Druckkraft von etwa `F ≈ 2π·η·T / lead` ≈ **60–110 N** für einen Motor mit 0,4–0,65 N·m bei einem Spindelwirkungsgrad η ≈ 0,4–0,5 — genug für ein Sustain‑Pedal, aber die 16‑mm‑Steigung ist „schnell" (geringe mechanische Übersetzung), daher würde ich zu einem **drehmomentstärkeren NEMA17 (≥ 50 N·cm) bei 24 V** tendieren.

*Quellen: MKS SERVO42, BIGTREETECH S42B, StepperOnline CL42T / ISDT17‑20, TMC2209 (StallGuard4), Vertiq/Fortiq‑Dokumentation. Vollständiger Entwurf: das Review‑PDF des Teams.*

</td>
</tr>
</table>

---

### 👀 Das bFaaaP‑Team prüft das gerade

> Das ist eine Frage der **Spur ② („braucht die Bauenden")** — siehe [wie der KI‑gestützte Support funktioniert](ai-support.md).
> Jeder Kommentar wird mit den **eigenen Worten** des jeweiligen Mitglieds gefüllt, sobald es antwortet: **Narusawa hat geantwortet**;
> **Tanaka und Taguchi prüfen noch** (Platzhalter unten). Die abgestimmte Schlussfolgerung wird in die
> [Pro‑Bauanleitung](build/pro.md) und die [Hinweise zur Hardware‑Verfügbarkeit](../../../device-pro-acoustic/HARDWARE-AVAILABILITY.md) eingearbeitet.

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/narusawa.png" width="104" alt="Avatar von Hiroyuki Narusawa"></td>
<td valign="top">

**🛠️ Hiroyuki Narusawa** &nbsp;·&nbsp; <sub>Pedalgerät / Firmware — *hat das funktionierende Gerät gebaut*</sub>

✅ *Geantwortet (2026‑06‑26).* Beim Nachfolgemotor tendiere ich zu **Option A — einem Closed‑Loop‑Treiber**. Ich erwäge entweder **MKS SERVO42C/D + einen NEMA17** oder **einen Closed‑Loop‑Schrittmotor mit eingebautem Treiber der NEMA17‑Klasse**. Könnte die **KI die Firmware** für diese Konfiguration entwerfen? *(Das CAD wird noch ergänzt / ausgetauscht, daher sind die mechanischen Dateien noch nicht final.)*

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/tanaka.png" width="104" alt="Avatar von Haruto Tanaka"></td>
<td valign="top">

**⚡ Haruto Tanaka** &nbsp;·&nbsp; <sub>Elektrotechnik</sub>

🕐 *Prüft.* Wurde gebeten, die **elektrische Seite** zu prüfen: ein geeignetes NEMA17‑Drehmoment/‑Modell, die Treiberwahl und ob die 24‑V‑/Stromwerte und die Kraftabschätzung standhalten. Seine Antwort erscheint hier.

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/taguchi.png" width="104" alt="Avatar von Taguchi"></td>
<td valign="top">

**💻 Taguchi** &nbsp;·&nbsp; <sub>Softwaretechnik</sub>

🕐 *Prüft — braucht etwas mehr Zeit.* Wurde nach den Auswirkungen auf **Firmware/Steuerung** gefragt — wie sich STEP/DIR + ein Lastsignal in die bestehende Pico‑Schleife einfügen. Seine Antwort erscheint hier.

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/ai.png" width="104" alt="Avatar des KI‑Assistenten"></td>
<td valign="top">

**🤖 KI‑Assistent** &nbsp;·&nbsp; <sub>Folge‑Antwort</sub>

Danke, Narusawa — damit landen wir bei **Option A**, die dem ursprünglichen IQ‑Verhalten am nächsten kommt. Beide Varianten melden **Last/Schleppfehler über UART (oder CAN)**, sodass die Firmware die IQ‑artige Kalibrierung „drücken, bis die Reaktionskraft ansteigt" wiederherstellen kann.

✅ **Entwurf geliefert (2026‑06‑26):**
[`bFaaaP_autopro_pico_stepperA_draft_20260626.ino`](../../../device-pro-acoustic/firmware/pico/bFaaaP_autopro_pico_stepperA_draft_20260626.ino)
— STEP/DIR‑Bewegung + eine *Position‑anfahren‑und‑halten*‑Schleife + ein `readLoad()` (Treiber‑seriell, mit ADC‑Fallback) für den Kraftschritt; es bildet die **0–99** der App auf einen Zielwert ab, hält die **50‑mm‑Hubgrenze** ein und **behebt den STEP/DIR‑Pinkonflikt der v052B** (der Step‑Impuls teilte sich GP13 mit dem Summer). Es ist **ungetestet — ein Ausgangspunkt für den Prüfstand**, wobei die genauen Protokollbytes des Treibers als TODO offenbleiben.

**Als Nächstes:** Narusawa testet es auf dem Prüfstand; dann prüfen Tanaka (Elektrik) & Taguchi (Software), bevor es als fertig gilt. *(Die mechanischen Dateien bleiben offen, bis das CAD final ist.)*

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/narusawa.png" width="104" alt="Avatar von Hiroyuki Narusawa"></td>
<td valign="top">

**🛠️ Hiroyuki Narusawa** &nbsp;·&nbsp; <sub>Folge‑Antwort</sub>

✅ **Es kompiliert** — gute Arbeit. Taguchi und Tanaka können es von hier aus verfeinern. Ein paar Änderungen für den Nachfolger: **HX711 weglassen** — die Luftpumpe einfach **fest 40 s** laufen lassen (das Luft‑**Ventil ist stromlos geschlossen** und wird nur geöffnet, wenn das Gerät vom Klavier genommen wird). Und der **80‑µs‑STEP** wirkt zu schnell — das Pedal folgt vielleicht nicht, also verlangsame ihn.

</td>
</tr>
</table>

<table>
<tr>
<td width="120" valign="top"><img src="../../../docs/media/avatars/ai.png" width="104" alt="Avatar des KI‑Assistenten"></td>
<td valign="top">

**🤖 KI‑Assistent** &nbsp;·&nbsp; <sub>Folge‑Antwort</sub>

Erledigt: HX711 entfernt, den Airback auf ein **festes 40‑s**‑Aufpumpen mit dem Hinweis zum **stromlos geschlossenen Ventil** umgestellt und **STEP_PULSE_US 80 → 350 µs** verlangsamt (auf dem Prüfstand abstimmbar). Weiter an **Tanaka & Taguchi**, um das Treiberprotokoll zu verfeinern und die Raten abzustimmen. *(Genau dafür ist der KI‑gestützte Support da — die KI ist schnell, die Bauenden halten sie ehrlich.)*

</td>
</tr>
</table>

---

## Warum wir es so veröffentlichen

Die KI ist schnell und liest alles im Repository, aber sie **kann sich selbstbewusst irren** — und bei einer offenen Frage wie „der beste zu verwendende Motor" gibt es keine einzige Lehrbuchantwort. Das bFaaaP‑Team hat **das Gerät tatsächlich gebaut**, daher macht seine Prüfung aus einem plausiblen KI‑Entwurf etwas, dem man vertrauen kann. Diesen Austausch offen zu zeigen, ist der Punkt: Du siehst, *wie* die Antwort zustande kommt, nicht nur die Antwort.

**Hast du eine bessere Idee oder es mit einem anderen Motor gebaut?**
**[Mach bei der Diskussion mit →](https://github.com/TomoShishido/bfaaap_opensource/discussions)** — dein
Beitrag kann Teil dieses Threads und Teil der Doku werden.

---

*Die Mitglieder‑Avatare sind handgezeichnete Originalillustrationen von **Saki Shiokawa (塩川紗季)** (© Saki Shiokawa /
bFaaaP); nur der KI‑Avatar ist KI‑generiert (Gemini, in ihrem Stil) © Shishido & Associates. Siehe
[Medien‑Credits](../../../docs/media/CREDITS.md).*
