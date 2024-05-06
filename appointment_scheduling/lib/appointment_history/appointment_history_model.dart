import '/flutter_flow/flutter_flow_util.dart';
import 'appointment_history_widget.dart' show AppointmentHistoryWidget;
import 'package:flutter/material.dart';

class AppointmentHistoryModel
    extends FlutterFlowModel<AppointmentHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
