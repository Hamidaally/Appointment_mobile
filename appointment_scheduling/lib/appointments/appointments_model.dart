import '/flutter_flow/flutter_flow_util.dart';
import 'appointments_widget.dart' show AppointmentsWidget;
import 'package:flutter/material.dart';

class AppointmentsModel extends FlutterFlowModel<AppointmentsWidget> {
  ///  Local state fields for this page.

  DateTime? startDate;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
