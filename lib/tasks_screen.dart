/*import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/create_task_new_widget.dart';
import '../components/empty_list_tasks_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../task_details/task_details_widget.dart';*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyTasksWidget extends StatefulWidget {
  const MyTasksWidget({Key? key}) : super(key: key);

  @override
  _MyTasksWidgetState createState() => _MyTasksWidgetState();
}

class _MyTasksWidgetState extends State<MyTasksWidget>
    with TickerProviderStateMixin {
  // PagingController<DocumentSnapshot?, ToDoListRecord>? _pagingController;
  // Query? _pagingQuery;
  // List<StreamSubscription?> _streamSubscriptions = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  /*final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      hideBeforeAnimating: false,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 70),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };*/

  @override
  void initState() {
    super.initState();
    /*startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );*/
  }

  @override
  void dispose() {
    // _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        backgroundColor: Color(0xFF42BEA5),
        automaticallyImplyLeading: false,
        title: Text(
          'My Tasks',
          /*style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).white,
              ),*/
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      backgroundColor: Color(0xFFF1F4F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Color(0x230E151B),
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  // child: CreateTaskNewWidget(),
                ),
              );
            },
          ).then((value) => setState(() {}));
        },
        // backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        backgroundColor: Color(0xFF42BEA5),
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          // color: FlutterFlowTheme.of(context).white,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 53,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/waves@2x.png',
                      ).image,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Scheduled Tasks',
                    // style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
            ),
            /*Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child:
                    PagedListView<DocumentSnapshot<Object?>?, ToDoListRecord>(
                  pagingController: () {
                    final Query<Object?> Function(Query<Object?>) queryBuilder =
                        (toDoListRecord) => toDoListRecord
                            .where('user', isEqualTo: currentUserReference)
                            .where('toDoState', isEqualTo: false)
                            .orderBy('toDoDate');
                    if (_pagingController != null) {
                      final query = queryBuilder(ToDoListRecord.collection);
                      if (query != _pagingQuery) {
                        // The query has changed
                        _pagingQuery = query;
                        _streamSubscriptions.forEach((s) => s?.cancel());
                        _streamSubscriptions.clear();
                        _pagingController!.refresh();
                      }
                      return _pagingController!;
                    }

                    _pagingController = PagingController(firstPageKey: null);
                    _pagingQuery = queryBuilder(ToDoListRecord.collection);
                    _pagingController!.addPageRequestListener((nextPageMarker) {
                      queryToDoListRecordPage(
                        queryBuilder: (toDoListRecord) => toDoListRecord
                            .where('user', isEqualTo: currentUserReference)
                            .where('toDoState', isEqualTo: false)
                            .orderBy('toDoDate'),
                        nextPageMarker: nextPageMarker,
                        pageSize: 25,
                        isStream: true,
                      ).then((page) {
                        _pagingController!.appendPage(
                          page.data,
                          page.nextPageMarker,
                        );
                        final streamSubscription =
                            page.dataStream?.listen((data) {
                          final itemIndexes = _pagingController!.itemList!
                              .asMap()
                              .map((k, v) => MapEntry(v.reference.id, k));
                          data.forEach((item) {
                            final index = itemIndexes[item.reference.id];
                            final items = _pagingController!.itemList!;
                            if (index != null) {
                              items.replaceRange(index, index + 1, [item]);
                              _pagingController!.itemList = {
                                for (var item in items) item.reference: item
                              }.values.toList();
                            }
                          });
                          setState(() {});
                        });
                        _streamSubscriptions.add(streamSubscription);
                      });
                    });
                    return _pagingController!;
                  }(),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  builderDelegate: PagedChildBuilderDelegate<ToDoListRecord>(
                    // Customize what your widget looks like when it's loading the first page.
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      child: EmptyListTasksWidget(),
                    ),
                    itemBuilder: (context, _, listViewIndex) {
                      final listViewToDoListRecord =
                          _pagingController!.itemList![listViewIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsWidget(
                                  toDoNote: listViewToDoListRecord.reference,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Color(0x230E151B),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 12, 0, 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listViewToDoListRecord.toDoName!,
                                          style: FlutterFlowTheme.of(context)
                                              .title2,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                dateTimeFormat(
                                                    'MMMEd',
                                                    listViewToDoListRecord
                                                        .toDoDate!),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 4, 0, 0),
                                              child: Text(
                                                dateTimeFormat(
                                                    'jm',
                                                    listViewToDoListRecord
                                                        .toDoDate!),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                'From: Riyadh',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 4, 0, 0),
                                              child: Text(
                                                'To; Jeddah',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                'Truck Number: ABC123',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 12, 0),
                                      child: ToggleIcon(
                                        onPressed: () async {
                                          final toDoListUpdateData = {
                                            'toDoState': !listViewToDoListRecord
                                                .toDoState!,
                                          };
                                          await listViewToDoListRecord.reference
                                              .update(toDoListUpdateData);
                                        },
                                        value:
                                            listViewToDoListRecord.toDoState!,
                                        onIcon: Icon(
                                          Icons.check_circle,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          size: 25,
                                        ),
                                        offIcon: Icon(
                                          Icons.radio_button_off,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ).animated(
                            [animationsMap['containerOnPageLoadAnimation']!]),
                      );
                    },
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
