import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmList extends StatelessWidget {
  final List<DateTime> alarms;
  final Map<int, bool> alarmStatus;
  final Function(int, bool) onToggle;
  final Function(int) onDelete;

  const AlarmList({
    super.key,
    required this.alarms,
    required this.alarmStatus,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (alarms.isEmpty) return const Text("No alarms set");

    return Column(
      children: List.generate(alarms.length, (index) {
        final alarm = alarms[index];
        final isOn = alarmStatus[index] ?? true;

        final timeFormatted = DateFormat('hh:mm a').format(alarm.toLocal());
        final dateFormatted = DateFormat(
          'EEE, d MMM yyyy',
        ).format(alarm.toLocal());

        return Dismissible(
          key: Key(alarm.toString() + index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) => onDelete(index),
          child: Container(
            height: 84,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF3C3D3F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeFormatted,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          dateFormatted,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Switch(
                      value: isOn,
                      onChanged: (val) => onToggle(index, val),
                      activeThumbColor: Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
