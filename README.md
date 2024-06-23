# Sallen-Key Bandpassfilter Projekt

## Projektbeschreibung
Dieses Projekt beinhaltet die Entwicklung eines Sallen-Key Bandpassfilters, der für eine Mittenfrequenz von 50 kHz ausgelegt ist. Der Filter ist so konzipiert, dass er eine Grundverstärkung von A0 = 1 aufweist und unerwünschte Frequenzen möglichst gut dämpft. Die maximale Welligkeit des Filters beträgt 12 dB, und das Filter soll eine hohe Impedanz-Wandlung aufweisen.

## Autoren
- Erik Haubrich
- Marco Müller

## Betreuer
- Peter Jost

## Institution
Juventus Technikerschule HF

## Semester
4. Semester, TS TSE 2202 A 04

## Inhaltsverzeichnis
1. [Einleitung](#einleitung)
2. [Projektaufgaben](#projektaufgaben)
3. [Software und Werkzeuge](#software-und-werkzeuge)
4. [Fazit](#fazit)
5. [Kontakt](#kontakt)

## Einleitung
In der modernen Elektronik spielt die Filtertechnik eine entscheidende Rolle bei der Verarbeitung und Manipulation von Signalen. Filter werden verwendet, um unerwünschte Frequenzkomponenten zu unterdrücken und gewünschte Frequenzbereiche zu verstärken oder zu isolieren. Ein besonders nützliches Filter ist der Sallen-Key Bandpassfilter, der aufgrund seiner Einfachheit und Effektivität weit verbreitet ist.

Das Ziel dieses Projekts ist die Entwicklung eines Sallen-Key Bandpassfilters, der eine Grundverstärkung von A0 = 1 aufweist und eine Frequenz von fg = 50 kHz passieren lässt, während andere Frequenzen möglichst gut gedämpft werden. Die Welligkeit des Filters soll maximal 12 dB betragen und das Filter eine hohe Impedanz-Wandlung aufweisen.

## Projektaufgaben
1. **Bestimmen der Übertragungsfunktionen f(p)**
   - Berechnung der Übertragungsfunktion der sekundärseitig leerlaufenden Schaltung in Abhängigkeit der Kreisfrequenz ω und der einzelnen Komponenten.

2. **Dimensionieren der Schaltung**
   - Dimensionierung des Filters basierend auf der berechneten Übertragungsfunktion, sodass er bei einer Grenzfrequenz von 50 kHz eine steil verlaufende Bandpasscharakteristik aufweist. Die Grundverstärkung soll A0 = 1 sein. Es werden mehrere Varianten geprüft.

3. **Darstellen der Übertragungsfunktion**
   - Darstellung der Übertragungsfunktionen des dimensionierten Filters nach Bode in Amplituden- und Phasengang.

4. **Simulation der Schaltung**
   - Simulation der Schaltung mit einem geeigneten Werkzeug und Untersuchung der Einflüsse der Toleranzen der Bauteile.

5. **Stabilität der Schaltung**
   - Überprüfung der Stabilität der Schaltung anhand der Pol- und Nullstellen.

6. **Aufbauen und Ausmessen der Schaltung**
   - Aufbau der Schaltung mit den berechneten Bauteilen und Durchführung von Messungen. Interpretation der Messresultate.

7. **Einschwingverhalten**
   - Berechnung und grafische Darstellung der Sprungantwort u2(t) für den Bandpassfilter.

8. **Vergleich der Messung und Simulation**
   - Vergleich der praktischen Messungen mit den theoretischen Berechnungen und Simulationsergebnissen.

## Software und Werkzeuge
- MATLAB R2022b
- LTspice V17.2.4 für MacOS
- NI Multisim 14.1
- PicoScope 2204A SN: JO243/1412

## Fazit
Im Rahmen dieses Projekts wurde ein Sallen-Key Bandpassfilter entwickelt, simuliert und praktisch umgesetzt. Die detaillierte Bestimmung der Übertragungsfunktionen, die sorgfältige Dimensionierung der Bauteile und die anschließende Simulation ermöglichten ein tiefgehendes Verständnis der Filtercharakteristik und der Herausforderungen bei der Umsetzung. Die Simulationen mit LTspice und MATLAB zeigten eine gute Übereinstimmung mit den theoretischen Berechnungen. Die praktische Umsetzung offenbarte Herausforderungen, insbesondere durch Störeinflüsse und Streukapazitäten, die in einer professionellen PCB-Umsetzung minimiert werden könnten. Trotz suboptimaler Bedingungen konnte die gewünschte Filtercharakteristik weitgehend erreicht werden.

## Kontakt
Für weitere Informationen und Fragen wenden Sie sich bitte an:
- **Erik Haubrich**
- **Marco Müller**
- **Peter Jost (Betreuer)**

Juventus Technikerschule HF  
www.technikerschule.ch