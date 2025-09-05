import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAlarmButton extends StatefulWidget {
  final Function(DateTime) onAlarmAdded;

  const AddAlarmButton({super.key, required this.onAlarmAdded});

  @override
  State<AddAlarmButton> createState() => _AddAlarmButtonState();
}

class _AddAlarmButtonState extends State<AddAlarmButton> {
  Future<void> _pickDateTime() async {
    // Pick a date
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted || date == null) return;

    // Pick a time
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (!mounted || time == null) return;

    // Combine date and time
    final DateTime selected = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    // Prevent adding past alarms
    if (selected.isBefore(DateTime.now())) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot add an alarm in the past")),
      );
      return;
    }

    // Add the alarm
    widget.onAlarmAdded(selected);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _pickDateTime,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4D4D4D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Text(
          "Add Alarm",
          style: GoogleFonts.oxygen(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
