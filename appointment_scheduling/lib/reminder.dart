import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'Services/notifi_service.dart';

DateTime scheduleTime = DateTime.now();

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Appointment Reminder"),),
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            DatePickerTxt(),
             ScheduleBtn(),
          ],
        ),
      ),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
       BottomPicker.dateTime(
    dismissable: true,
    initialDateTime: DateTime.now(),
    pickerTitle: const Text("Schedule notification"),
    onChange: (value) {},
    onSubmit: (value) {
    scheduleTime = value;
    },
  ).show(context);
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
            title: 'Your appointment will be coming soon.',
            body: '$scheduleTime',
            scheduledNotificationDateTime: scheduleTime);
      },
    );
  }
}