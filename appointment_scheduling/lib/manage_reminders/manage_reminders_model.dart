import '/flutter_flow/flutter_flow_util.dart';
import 'manage_reminders_widget.dart' show ManageRemindersWidget;
import 'package:flutter/material.dart';

class ManageRemindersModel extends FlutterFlowModel<ManageRemindersWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
