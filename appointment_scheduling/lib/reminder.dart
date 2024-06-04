import 'package:appointment_scheduling/backend/schema/appointments_record.dart';
import 'package:appointment_scheduling/flutter_flow/flutter_flow_util.dart';
import 'package:appointment_scheduling/manage_reminders/manage_reminders_widget.dart';
import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'Services/notifi_service.dart';

class Reminder extends StatefulWidget {
  final AppointmentsRecord record;
  const Reminder({
    super.key,
    required this.record,
  });

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  DateTime? scheduleTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Appointment Reminder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (scheduleTime != null)
              Text(
                  "${DateFormat.yMMMMEEEEd().format(scheduleTime!)} ${DateFormat.jm().format(scheduleTime!)}"),
            TextButton(
              onPressed: () {
                BottomPicker.dateTime(
                  dismissable: true,
                  initialDateTime:
                      DateTime.now().add(const Duration(minutes: 30)),
                  minDateTime: DateTime.now(),
                  pickerTitle: const Text("Schedule notification"),
                  onChange: (value) {},
                  onSubmit: (value) {
                    setState(() {
                      scheduleTime = value;
                    });
                  },
                ).show(context);
              },
              child: const Text(
                'Select Date Time',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            if (scheduleTime != null)
              ElevatedButton(
                child: const Text('Schedule notifications'),
                onPressed: () {
                  debugPrint('Notification Scheduled for $scheduleTime');
                  NotificationService.scheduleNotification(
                    title: 'Your appointment will be coming soon.',
                    body: widget.record.reference.id,
                    scheduledNotificationDateTime: scheduleTime!,
                    payLoad: widget.record.toString(),
                  );
                  scheduled.add(widget.record);
                  showSnackbar(context, "Appointment scheduled");
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
