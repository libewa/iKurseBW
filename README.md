iKurseBW
========

- Kurswahl mobil
- nur lokal
- ohne Datenspeicherung
- flexibel
- schnell

## Was ist das hier?

Eine App, die deine Kurswahl für die Oberstufe führt und validiert, um dir und deinen Oberstufenberatern das Leben leicht zu machen.

## Wie funktioniert das?

Lade den Quellcode herunter, öffne das Projekt in Xcode, lade es auf dein iPhone, iPad, deine Apple Vision Pro, oder in den Simulator, und folge der (wirklich einfachen) Benutzerführung.

# Wie benutze ich den Wahlzettel *meiner* Schule?

Die App kann Wahlzettel aus einer JSON-Datei laden. Ein passendes Schema befindet sich in [iKurseBW/Resources/schema.json](iKurseBW/Resources/schema.json). Man *könnte* auch noch eine App dafür schreiben, aber das ist noch nicht geschehen.

# QnA/Häufige Fehler

### Wo `exe`/App Store?

Apps in den App Store zu laden kostet 99 USD **im Jahr**. Vielleicht mache ich das irgendwann, aber das Signieren für eigene Geräte (für 10 Tage) ist für jeden kostenlos.

### "Signing for "iKurseBW" requires a development team. Select a development team in the Signing & Capabilities editor."

Melde dich mit einem Apple Account bei Xcode an (Xcode -> Settings… -> Accounts -> + -> Apple Account) und wähle das Development Team aus (Klicke auf die Fehlermeldung, um zum passenden Menü zu kommen).

Alternativ führe die App in einem Simulator aus.

### "This Apple ID cannot be used for development with Xcode."

Du hast versucht, einen Kinder- oder Schulaccount für Xcode zu benutzen.

## Screenshots

![Der Startbildschirm der App. Er führt den Nutzer mit viel Text in den Zweck der App ein. Der Nutzer kann auch eine Datei mit verfügbaren Kursen auswählen.](./Presentation%20Assets/0start18.png)
![Eine lange Liste für die Wahl des ersten Leistungskurses](./Presentation%20Assets/1lk18.png)
![Zwei Picker zur Auswahl der mündlich geprüften Basiskurse. Beide sind schon ausgewählt.](./Presentation%20Assets/2bm18.png)
![Ein zweigeteilter Bildschirm zur Auswahl weiterer fehlender Kurse](./Presentation%20Assets/3fehlen18.png)
![Der selbe Bildschirm. Nun wurden einige Kurse ausgewählt, und im oberen Teil erscheint eine Warnung, dass 42 Kurse zwar erlaubt, aber nicht empfohlen wären.](./Presentation%20Assets/4warnung18.png)
![Eine Liste der gewählten Kurse, mit den Wochenstunden und der Wahlart.](./Presentation%20Assets/5ende18.png)