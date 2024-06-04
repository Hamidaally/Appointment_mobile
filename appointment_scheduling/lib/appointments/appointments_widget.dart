import 'package:appointment_scheduling/Services/notifi_service.dart';
import 'package:appointment_scheduling/backend/schema/appointments_record.dart';
import 'package:appointment_scheduling/reminder.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'appointments_model.dart';
export 'appointments_model.dart';

class AppointmentsWidget extends StatefulWidget {
  const AppointmentsWidget({super.key});

  @override
  State<AppointmentsWidget> createState() => _AppointmentsWidgetState();
}

class _AppointmentsWidgetState extends State<AppointmentsWidget>
    with TickerProviderStateMixin {
  late AppointmentsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppointmentsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.startDate = getCurrentTimestamp;
      });
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List<Map<String, dynamic>> records = [];
  List<Map<String, dynamic>> results = [];

  bool isSearching = false;

  void searchAppointments(String value) {
    setState(() {
      results = records.where((element) {
        UsersRecord user = element['user'];
        return user.displayName.contains(value);
      }).toList();
    });
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(90.0, 0.0, 0.0, 0.0),
            child: Text(
              'iCARE Appointments System',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 4.0, 16.0, 0.0),
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    obscureText: false,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          if (!isSearching) {
                            isSearching = true;
                          }
                        });
                        searchAppointments(value);
                      } else {
                        setState(() {
                          isSearching = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      isDense: false,
                      labelText: 'Search for doctor...',
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color.fromARGB(255, 4, 5, 6),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF1F4F8),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF4B39EF),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF1F4F8),
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: Color(0xFF57636C),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF14181B),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    maxLines: null,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
                if (isSearching)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: results.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewAppointmentsRecord =
                          results[listViewIndex]['record'];
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 1.0),
                        child: Builder(
                          builder: (context) {
                            final containerUsersRecord =
                                results[listViewIndex]['user'];
                            return Container(
                              width: 100.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.0,
                                    color: Color(0xFFE0E3E7),
                                    offset: Offset(
                                      0.0,
                                      1.0,
                                    ),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Image.network(
                                        containerUsersRecord.photoUrl,
                                        width: 60.0,
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              containerUsersRecord.displayName,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color:
                                                        const Color(0xFF14181B),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12.0, 0.0, 10.0, 0.0),
                                                  child: Text(
                                                    dateTimeFormat(
                                                        'M/d H:mm',
                                                        listViewAppointmentsRecord
                                                            .time!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Raleway',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Reminder(
                                              record:
                                                  listViewAppointmentsRecord,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.notifications_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          showDragHandle: true,
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor:
                                              Theme.of(context).cardColor,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    "Edit Appointment",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                              containerUsersRecord
                                                                  .photoUrl),
                                                    ),
                                                    title: Text(
                                                        containerUsersRecord
                                                            .displayName),
                                                    subtitle: Text(
                                                      dateTimeFormat(
                                                          DateFormat
                                                              .ABBR_MONTH_WEEKDAY_DAY,
                                                          listViewAppointmentsRecord
                                                              .time),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      showDatePicker(
                                                          context: context,
                                                          firstDate: DateTime
                                                                  .now()
                                                              .add(
                                                                  const Duration(
                                                                      days: 1)),
                                                          lastDate:
                                                              DateTime.now()
                                                                  .add(
                                                            const Duration(
                                                                days: 90),
                                                          )).then(
                                                        (value) {
                                                          if (value != null) {
                                                            showSnackbar(
                                                                context,
                                                                "Updating time");
                                                            DateTime newDate =
                                                                value.copyWith(
                                                              hour:
                                                                  listViewAppointmentsRecord
                                                                      .time!
                                                                      .hour,
                                                              minute:
                                                                  listViewAppointmentsRecord
                                                                      .time!
                                                                      .minute,
                                                            );
                                                            listViewAppointmentsRecord
                                                                .reference
                                                                .update(
                                                                    mapToFirestore(
                                                              <String, dynamic>{
                                                                'time': newDate,
                                                              }.withoutNulls,
                                                            ))
                                                                .then((_) {
                                                              showSnackbar(
                                                                  context,
                                                                  "appointment updated");
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          }
                                                        },
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                    child: const Text(
                                                        "Change Appointment Date"),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      content: const Text(
                                                          'Do you want to delete your appointment?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                          child: const Text(
                                                              'Confirm'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ) ??
                                                false;
                                        if (confirmDialogResponse) {
                                          await listViewAppointmentsRecord
                                              .reference
                                              .delete();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Appointment deleted successfully',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        }
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Color(0xFFEC1F15),
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                  child: StreamBuilder<List<AppointmentsRecord>>(
                    stream: queryAppointmentsRecord(
                      queryBuilder: (appointmentsRecord) => appointmentsRecord
                          .where(
                            'uid',
                            isEqualTo: currentUserReference,
                          )
                          .orderBy('time'),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<AppointmentsRecord> listViewAppointmentsRecordList =
                          snapshot.data!;
                      NotificationService.getScheduled(
                          listViewAppointmentsRecordList);
                      return (isSearching)
                          ? const SizedBox.shrink()
                          : ListView.builder(
                              controller: controller,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewAppointmentsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewAppointmentsRecord =
                                    listViewAppointmentsRecordList[
                                        listViewIndex];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 1.0),
                                  child: StreamBuilder<UsersRecord>(
                                    stream: UsersRecord.getDocument(
                                        listViewAppointmentsRecord
                                            .parentReference),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final containerUsersRecord =
                                          snapshot.data!;
                                      records.add({
                                        'user': containerUsersRecord,
                                        'record': listViewAppointmentsRecord,
                                      });
                                      return Container(
                                        width: 100.0,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 0.0,
                                              color: Color(0xFFE0E3E7),
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                                child: Image.network(
                                                  containerUsersRecord.photoUrl,
                                                  width: 60.0,
                                                  height: 60.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Text(
                                                        containerUsersRecord
                                                            .displayName,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              color: const Color(
                                                                  0xFF14181B),
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              4.0, 0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                            child: Text(
                                                              dateTimeFormat(
                                                                  'M/d H:mm',
                                                                  listViewAppointmentsRecord
                                                                      .time!),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Raleway',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Reminder(
                                                        record:
                                                            listViewAppointmentsRecord,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.notifications_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    showDragHandle: true,
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .cardColor,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Text(
                                                              "Edit Appointment",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    CachedNetworkImageProvider(
                                                                        containerUsersRecord
                                                                            .photoUrl),
                                                              ),
                                                              title: Text(
                                                                  containerUsersRecord
                                                                      .displayName),
                                                              subtitle: Text(
                                                                dateTimeFormat(
                                                                    DateFormat
                                                                        .ABBR_MONTH_WEEKDAY_DAY,
                                                                    listViewAppointmentsRecord
                                                                        .time),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                showDatePicker(
                                                                    context:
                                                                        context,
                                                                    firstDate: DateTime
                                                                            .now()
                                                                        .add(const Duration(
                                                                            days:
                                                                                1)),
                                                                    lastDate:
                                                                        DateTime.now()
                                                                            .add(
                                                                      const Duration(
                                                                          days:
                                                                              90),
                                                                    )).then(
                                                                  (value) {
                                                                    if (value !=
                                                                        null) {
                                                                      showSnackbar(
                                                                          context,
                                                                          "Updating time");
                                                                      DateTime
                                                                          newDate =
                                                                          value
                                                                              .copyWith(
                                                                        hour: listViewAppointmentsRecord
                                                                            .time!
                                                                            .hour,
                                                                        minute: listViewAppointmentsRecord
                                                                            .time!
                                                                            .minute,
                                                                      );
                                                                      listViewAppointmentsRecord
                                                                          .reference
                                                                          .update(
                                                                              mapToFirestore(
                                                                        <String,
                                                                            dynamic>{
                                                                          'time':
                                                                              newDate,
                                                                        }.withoutNulls,
                                                                      ))
                                                                          .then(
                                                                              (_) {
                                                                        showSnackbar(
                                                                            context,
                                                                            "appointment updated");
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                              ),
                                                              child: const Text(
                                                                  "Change Appointment Date"),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 24.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  var confirmDialogResponse =
                                                      await showDialog<bool>(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                content: const Text(
                                                                    'Do you want to delete your appointment?'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: const Text(
                                                                        'Confirm'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;
                                                  if (confirmDialogResponse) {
                                                    await listViewAppointmentsRecord
                                                        .reference
                                                        .delete();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Appointment deleted successfully',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Color(0xFFEC1F15),
                                                  size: 24.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      200.0, 0.0, 0.0, 10.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('select_categories1');
                    },
                    text: 'New Appointment',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Raleway',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
