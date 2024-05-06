import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<DateTime> getAvailSlots(
  List<DateTime> reservedSlots,
  DateTime startDateArg,
) {
  List<DateTime> availableAppointments = [];
  DateTime now = startDateArg;
  DateTime startTime = DateTime(now.year, now.month, now.day, now.hour, 0);
  DateTime endTime = startTime.add(const Duration(days: 2));
  for (DateTime currentTime = startTime;
      currentTime.isBefore(endTime);
      currentTime = currentTime.add(const Duration(hours: 1))) {
    bool isReserved = false;
    for (DateTime reservedTime in reservedSlots) {
      if (currentTime.year == reservedTime.year &&
          currentTime.month == reservedTime.month &&
          currentTime.day == reservedTime.day &&
          currentTime.hour == reservedTime.hour) {
        isReserved = true;
        break;
      }
    }
    if (!isReserved && currentTime.hour >= 9 && currentTime.hour <= 17) {
      availableAppointments.add(currentTime);
    }
  }
  List<DateTime> availableSlots = availableAppointments
      .where((dateTime) => dateTime.day == availableAppointments[0].day)
      .toList();
  return availableSlots;
}
