# ⏰ Alarm App  

A Flutter-based alarm application with location-aware features and persistent storage using `shared_preferences`.  

---

## 🚀 Features  
- Set alarms with custom date & time  
- Save alarms locally with `shared_preferences` (persistent even after app restarts)  
- Location-aware functionality (latitude & longitude → real address)  
- Simple & clean UI built with [Material Design](https://m3.material.io/)  

---

## 🛠️ Tools & Packages Used  

- [Flutter](https://flutter.dev/) – Cross-platform UI framework  
- [Dart](https://dart.dev/) – Programming language  
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) – Store alarms locally as key-value pairs  
- [`geolocator`](https://pub.dev/packages/geolocator) – Access device location  
- [`geocoding`](https://pub.dev/packages/geocoding) – Convert latitude/longitude to real address  
- [`google_fonts`](https://pub.dev/packages/google_fonts) – Custom fonts  
- [`intl`](https://pub.dev/packages/intl) – Date & time formatting  

---

## ⚙️ Project Setup  

1. **Clone the repository**  
   ```bash
   git clone https://github.com/abdulla30r/alarm_flutter.git
   cd alarm
   ```

2. **Install dependencies**  
   ```bash
   flutter pub get
   ```

3. **Run the app**  
   ```bash
   flutter run
   ```

---

## 📸 Screenshots  

<p align="center">
  <img src="assets/screenshots/home.png" alt="Home" width="250"/>
  <img src="assets/screenshots/set_alarm.png" alt="Set Alarm" width="250"/>
  <img src="assets/screenshots/location.png" alt="Location" width="250"/>
</p> 

---

## 💾 How Storage Works  

Alarms are stored locally using [`shared_preferences`](https://pub.dev/packages/shared_preferences).  
Each alarm is saved as a JSON string in key-value pairs, for example:  

```json
{
  "alarms": [
    {
      "time": "07:30",
      "date": "2025-09-07",
      "label": "Morning Run"
    },
    {
      "time": "21:00",
      "date": "2025-09-07",
      "label": "Study Reminder"
    }
  ]
}
```

This ensures alarms remain available even after restarting the app.  

---

## 📌 Notes  
- Ensure your device/emulator has **location permissions** enabled.  
- On **Android**, configure `AndroidManifest.xml` for location usage.  
- On **iOS**, add required location permission keys in `Info.plist`.  

---

## 🔮 Future Improvements  
- Add local notifications to trigger alarms  

