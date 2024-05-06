import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'appoint_action_model.dart';
export 'appoint_action_model.dart';

class AppointActionWidget extends StatefulWidget {
  const AppointActionWidget({
    super.key,
    required this.user,
    required this.time,
    required this.userid,
  });

  final String? user;
  final DateTime? time;
  final DocumentReference? userid;

  @override
  State<AppointActionWidget> createState() => _AppointActionWidgetState();
}

class _AppointActionWidgetState extends State<AppointActionWidget> {
  late AppointActionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppointActionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            child: Text(
              'Book your appointment',
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    fontFamily: 'Readex Pro',
                    color: const Color(0xFF4B39EF),
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                  child: Text(
                    'Book with${widget.user} at ${dateTimeFormat('MMMMEEEEd', widget.time)}',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Outfit',
                          color: const Color(0xFF14181B),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ],
          ),
          FFButtonWidget(
            onPressed: () async {
              await AppointmentsRecord.createDoc(widget.userid!)
                  .set(createAppointmentsRecordData(
                time: widget.time,
                uid: currentUserReference,
              ));
              Navigator.pop(context);

              context.pushNamed('Appointments');
            },
            text: 'Book',
            options: FFButtonOptions(
              width: 130.0,
              height: 40.0,
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: const Color(0xFF4B39EF),
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
              elevation: 3.0,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
              hoverColor: const Color(0xFF2B16ED),
              hoverTextColor: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
