import '/flutter_flow/flutter_flow_util.dart';
import 'set_reminder_widget.dart' show SetReminderWidget;
import 'package:flutter/material.dart';

class SetReminderModel extends FlutterFlowModel<SetReminderWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
