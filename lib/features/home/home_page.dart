import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/alarm_list.dart';
import '../../common_widgets/add_alarm_button.dart';
import '../../common_widgets/location_section.dart';

class HomePage extends StatefulWidget {
  final Map<String, double>? location;

  const HomePage({super.key, this.location});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? address;
  List<DateTime> alarms = [];
  Map<int, bool> alarmStatus = {}; // track ON/OFF for each alarm

  @override
  void initState() {
    super.initState();
    loadAlarms(); // Load saved alarms when app starts
  }

  // Load alarms from local storage
  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsData = prefs.getString('alarms');
    if (alarmsData != null) {
      final decoded = jsonDecode(alarmsData) as List;
      setState(() {
        alarms = decoded.map((e) => DateTime.parse(e['time'])).toList();
        alarmStatus = {
          for (int i = 0; i < decoded.length; i++)
            i: decoded[i]['isOn'] as bool,
        };
      });
    }
  }

  // Save alarms to local storage
  Future<void> saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final data = alarms.asMap().entries.map((entry) {
      return {
        'time': entry.value.toIso8601String(),
        'isOn': alarmStatus[entry.key] ?? true,
      };
    }).toList();
    await prefs.setString('alarms', jsonEncode(data));
  }

  void setAddress(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  void addAlarm(DateTime alarm) {
    setState(() {
      alarms.add(alarm);
      alarmStatus[alarms.length - 1] = true; // default ON
    });
    saveAlarms();
  }

  void toggleAlarm(int index, bool value) {
    setState(() {
      alarmStatus[index] = value;
    });
    saveAlarms();
  }

  void deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
      alarmStatus.remove(index);

      // Rebuild alarmStatus map to keep indexes consistent
      final newStatus = <int, bool>{};
      for (int i = 0; i < alarms.length; i++) {
        newStatus[i] = alarmStatus[i] ?? true;
      }
      alarmStatus = newStatus;
    });
    saveAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocationSection(
                  location: widget.location,
                  address: address,
                  onAddressChanged: setAddress,
                ),
                const SizedBox(height: 20),
                AddAlarmButton(onAlarmAdded: addAlarm),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Alarms",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                AlarmList(
                  alarms: alarms,
                  alarmStatus: alarmStatus,
                  onToggle: toggleAlarm,
                  onDelete: deleteAlarm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
