import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/ai_chat_component/ai_chat_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'list_page_model.dart';
export 'list_page_model.dart';
import '/utils/rustdesk_launcher.dart';
import '/utils/speech_recognition_widget.dart';

class ListPageWidget extends StatefulWidget {
  const ListPageWidget({
    super.key,
    int? tabIndexRef,
  }) : this.tabIndexRef = tabIndexRef ?? 0;

  final int tabIndexRef;

  @override
  State<ListPageWidget> createState() => _ListPageWidgetState();
}

class _ListPageWidgetState extends State<ListPageWidget>
    with TickerProviderStateMixin {
  late ListPageModel _model;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListPageModel());


    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: min(
          valueOrDefault<int>(
            widget!.tabIndexRef,
            0,
          ),
          2),
    )..addListener(() => safeSetState(() {}));
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                          FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                          FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Inter',
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                          ),
                          unselectedLabelStyle: TextStyle(),
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          padding: EdgeInsets.all(4.0),
                          tabs: [
                            Tab(
                              text: '백과사전',
                              icon: FaIcon(
                                FontAwesomeIcons.book,
                              ),
                            ),
                            Tab(
                              text: '커뮤니티',
                              icon: Icon(
                                Icons.message_rounded,
                              ),
                            ),
                            Tab(
                              text: '챗봇',
                              icon: FaIcon(
                                FontAwesomeIcons.robot,
                              ),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 12.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3.0,
                                                color: Color(0x33000000),
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                              )
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            border: Border.all(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 0.0, 12.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.search_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4.0, 0.0,
                                                        0.0, 0.0),
                                                    child: Container(
                                                      width: 200.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .textController1,
                                                        focusNode: _model
                                                            .textFieldFocusNode1,
                                                        onChanged: (_) =>
                                                            EasyDebounce
                                                                .debounce(
                                                              '_model.textController1',
                                                              Duration(
                                                                  milliseconds:
                                                                  2000),
                                                                  () async {
                                                                await queryDictionsRecordOnce()
                                                                    .then(
                                                                      (records) => _model
                                                                      .simpleSearchResults1 =
                                                                      TextSearch(
                                                                        records
                                                                            .map(
                                                                              (record) => TextSearchItem.fromTerms(
                                                                              record,
                                                                              [
                                                                                record.postTitle!,
                                                                                record.postDescription!,
                                                                                record.tag!
                                                                              ]),
                                                                        )
                                                                            .toList(),
                                                                      )
                                                                          .search(_model
                                                                          .textController1
                                                                          .text)
                                                                          .map((r) =>
                                                                      r.object)
                                                                          .toList(),
                                                                )
                                                                    .onError((_,
                                                                    __) =>
                                                                _model.simpleSearchResults1 =
                                                                [])
                                                                    .whenComplete(() =>
                                                                    safeSetState(
                                                                            () {}));
                                                              },
                                                            ),
                                                        autofocus: false,
                                                        obscureText: false,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: '검색...',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .override(
                                                            fontFamily:
                                                            'Inter',
                                                            fontSize:
                                                            16.0,
                                                            letterSpacing:
                                                            0.0,
                                                          ),
                                                          hintStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .override(
                                                            fontFamily:
                                                            'Inter',
                                                            letterSpacing:
                                                            0.0,
                                                          ),
                                                          enabledBorder:
                                                          InputBorder.none,
                                                          focusedBorder:
                                                          InputBorder.none,
                                                          errorBorder:
                                                          InputBorder.none,
                                                          focusedErrorBorder:
                                                          InputBorder.none,
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Inter',
                                                          letterSpacing:
                                                          0.0,
                                                        ),
                                                        cursorColor:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primary,
                                                        validator: _model
                                                            .textController1Validator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SpeechRecognitionWidget(
                                                  textController: _model.textController1,
                                                  onSearch: () async {
                                                    await queryDictionsRecordOnce()
                                                        .then(
                                                          (records) => _model.simpleSearchResults1 = TextSearch(
                                                        records
                                                            .map(
                                                              (record) => TextSearchItem.fromTerms(record, [
                                                            record.postTitle!,
                                                            record.postDescription!,
                                                            record.tag!
                                                          ]),
                                                        )
                                                            .toList(),
                                                      )
                                                          .search(_model.textController1?.text ?? '')
                                                          .map((r) => r.object)
                                                          .toList(),
                                                    )
                                                        .onError((_, __) => _model.simpleSearchResults1 = [])
                                                        .whenComplete(() => setState(() {}));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (_model.simpleSearchResults1
                                              .isNotEmpty) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      final simpleResultdiction =
                                                      _model
                                                          .simpleSearchResults1
                                                          .toList();

                                                      return ListView.builder(
                                                        padding:
                                                        EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                        Axis.vertical,
                                                        itemCount:
                                                        simpleResultdiction
                                                            .length,
                                                        itemBuilder: (context,
                                                            simpleResultdictionIndex) {
                                                          final simpleResultdictionItem =
                                                          simpleResultdiction[
                                                          simpleResultdictionIndex];
                                                          return Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                16.0,
                                                                4.0,
                                                                16.0,
                                                                8.0),
                                                            child: StreamBuilder<
                                                                List<
                                                                    DictionsRecord>>(
                                                              stream:
                                                              queryDictionsRecord(
                                                                singleRecord:
                                                                true,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                    SizedBox(
                                                                      width:
                                                                      50.0,
                                                                      height:
                                                                      50.0,
                                                                      child:
                                                                      CircularProgressIndicator(
                                                                        valueColor:
                                                                        AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<DictionsRecord>
                                                                card8DictionsRecordList =
                                                                snapshot
                                                                    .data!;
                                                                // Return an empty Container when the item does not exist.
                                                                if (snapshot
                                                                    .data!
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final card8DictionsRecord =
                                                                card8DictionsRecordList
                                                                    .isNotEmpty
                                                                    ? card8DictionsRecordList
                                                                    .first
                                                                    : null;

                                                                return InkWell(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    context
                                                                        .pushNamed(
                                                                      'DetailDiction',
                                                                      queryParameters:
                                                                      {
                                                                        'dictionDetails':
                                                                        serializeParam(
                                                                          simpleResultdictionItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'dictionDetails':
                                                                        simpleResultdictionItem,
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                          7.0,
                                                                          color:
                                                                          Color(0x2F1D2429),
                                                                          offset:
                                                                          Offset(
                                                                            0.0,
                                                                            3.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          8.0),
                                                                    ),
                                                                    child:
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          12.0,
                                                                          16.0,
                                                                          12.0),
                                                                      child:
                                                                      Column(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  simpleResultdictionItem.postTitle,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    fontFamily: 'Inter Tight',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            height:
                                                                            16.0,
                                                                            thickness:
                                                                            2.0,
                                                                            color:
                                                                            Color(0xFFF1F4F8),
                                                                          ),
                                                                          Text(
                                                                            simpleResultdictionItem.postDescription,
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                              fontFamily: 'Inter',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
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
                                                ],
                                              ),
                                            );
                                          } else {
                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  StreamBuilder<
                                                      List<DictionsRecord>>(
                                                    stream:
                                                    queryDictionsRecord(),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                            CircularProgressIndicator(
                                                              valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<DictionsRecord>
                                                      listViewDictionsRecordList =
                                                      snapshot.data!;

                                                      return ListView.builder(
                                                        padding:
                                                        EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                        Axis.vertical,
                                                        itemCount:
                                                        listViewDictionsRecordList
                                                            .length,
                                                        itemBuilder: (context,
                                                            listViewIndex) {
                                                          final listViewDictionsRecord =
                                                          listViewDictionsRecordList[
                                                          listViewIndex];
                                                          return Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                16.0,
                                                                4.0,
                                                                16.0,
                                                                8.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                              Colors
                                                                  .transparent,
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'DetailDiction',
                                                                  queryParameters:
                                                                  {
                                                                    'dictionDetails':
                                                                    serializeParam(
                                                                      listViewDictionsRecord,
                                                                      ParamType
                                                                          .Document,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    'dictionDetails':
                                                                    listViewDictionsRecord,
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                      7.0,
                                                                      color: Color(
                                                                          0x2F1D2429),
                                                                      offset:
                                                                      Offset(
                                                                        0.0,
                                                                        3.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8.0),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      16.0,
                                                                      12.0,
                                                                      16.0,
                                                                      12.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                        Row(
                                                                          mainAxisSize:
                                                                          MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              listViewDictionsRecord.postTitle,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                fontFamily: 'Inter Tight',
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        height:
                                                                        16.0,
                                                                        thickness:
                                                                        2.0,
                                                                        color: Color(
                                                                            0xFFF1F4F8),
                                                                      ),
                                                                      Text(
                                                                        listViewDictionsRecord
                                                                            .postDescription,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                          fontFamily: 'Inter',
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: Color(0xFF747474),
                                            borderRadius: 30.0,
                                            borderWidth: 3.0,
                                            buttonSize: 60.0,
                                            fillColor: Colors.white,
                                            icon: Icon(
                                              Icons.desktop_windows,
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              size: 30.0,
                                            ),
                                            onPressed: () async {
                                              try {
                                                await RustDeskLauncher.launchRustDesk();
                                              } catch (e) {
                                                print('Failed to launch RustDesk: $e');
                                              }
                                            },
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderColor: Color(0xFF747474),
                                          borderRadius: 30.0,
                                          borderWidth: 3.0,
                                          buttonSize: 60.0,
                                          fillColor: Colors.white,
                                          icon: Icon(
                                            Icons.person,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            size: 40.0,
                                          ),
                                          onPressed: () async {
                                            context.pushNamed('ChangeProflie');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 12.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 12.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.search_rounded,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                                size: 24.0,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      4.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController2,
                                                      focusNode: _model
                                                          .textFieldFocusNode2,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                            '_model.textController2',
                                                            Duration(
                                                                milliseconds: 2000),
                                                                () async {
                                                              await queryPostsRecordOnce()
                                                                  .then(
                                                                    (records) => _model
                                                                    .simpleSearchResults2 =
                                                                    TextSearch(
                                                                      records
                                                                          .map(
                                                                            (record) => TextSearchItem.fromTerms(
                                                                            record,
                                                                            [
                                                                              record.postTitle!,
                                                                              record.postDescription!,
                                                                              record.tag!
                                                                            ]),
                                                                      )
                                                                          .toList(),
                                                                    )
                                                                        .search(_model
                                                                        .textController2
                                                                        .text)
                                                                        .map((r) =>
                                                                    r.object)
                                                                        .toList(),
                                                              )
                                                                  .onError((_,
                                                                  __) =>
                                                              _model.simpleSearchResults2 =
                                                              [])
                                                                  .whenComplete(() =>
                                                                  safeSetState(
                                                                          () {}));
                                                            },
                                                          ),
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                      InputDecoration(
                                                        labelText: '검색...',
                                                        labelStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Inter',
                                                          fontSize:
                                                          16.0,
                                                          letterSpacing:
                                                          0.0,
                                                        ),
                                                        hintStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Inter',
                                                          letterSpacing:
                                                          0.0,
                                                        ),
                                                        enabledBorder:
                                                        InputBorder.none,
                                                        focusedBorder:
                                                        InputBorder.none,
                                                        errorBorder:
                                                        InputBorder.none,
                                                        focusedErrorBorder:
                                                        InputBorder.none,
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                      cursorColor:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .primary,
                                                      validator: _model
                                                          .textController2Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SpeechRecognitionWidget(
                                                textController: _model.textController2,
                                                onSearch: () async {
                                                  await queryPostsRecordOnce()
                                                      .then(
                                                        (records) => _model.simpleSearchResults2 = TextSearch(
                                                      records
                                                          .map(
                                                            (record) => TextSearchItem.fromTerms(record, [
                                                          record.postTitle!,
                                                          record.postDescription!,
                                                          record.tag!
                                                        ]),
                                                      )
                                                          .toList(),
                                                    )
                                                        .search(_model.textController2?.text ?? '')
                                                        .map((r) => r.object)
                                                        .toList(),
                                                  )
                                                      .onError((_, __) => _model.simpleSearchResults2 = [])
                                                      .whenComplete(() => setState(() {}));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          if (_model.simpleSearchResults2
                                              .isNotEmpty) {
                                            return Builder(
                                              builder: (context) {
                                                final simpleResult = _model
                                                    .simpleSearchResults2
                                                    .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  itemCount:
                                                  simpleResult.length,
                                                  itemBuilder: (context,
                                                      simpleResultIndex) {
                                                    final simpleResultItem =
                                                    simpleResult[
                                                    simpleResultIndex];
                                                    return Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16.0,
                                                          4.0,
                                                          16.0,
                                                          8.0),
                                                      child: StreamBuilder<
                                                          List<PostsRecord>>(
                                                        stream:
                                                        queryPostsRecord(
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                CircularProgressIndicator(
                                                                  valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                    FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<PostsRecord>
                                                          card8PostsRecordList =
                                                          snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final card8PostsRecord =
                                                          card8PostsRecordList
                                                              .isNotEmpty
                                                              ? card8PostsRecordList
                                                              .first
                                                              : null;

                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                            Colors
                                                                .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                'DetailPost',
                                                                queryParameters:
                                                                {
                                                                  'postDetail':
                                                                  serializeParam(
                                                                    simpleResultItem,
                                                                    ParamType
                                                                        .Document,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  'postDetail':
                                                                  simpleResultItem,
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                    7.0,
                                                                    color: Color(
                                                                        0x2F1D2429),
                                                                    offset:
                                                                    Offset(
                                                                      0.0,
                                                                      3.0,
                                                                    ),
                                                                  )
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    8.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    16.0,
                                                                    12.0,
                                                                    16.0,
                                                                    12.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            simpleResultItem.tag,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              fontFamily: 'Plus Jakarta Sans',
                                                                              color: Color(0xFF39D2C0),
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            simpleResultItem.author,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              fontFamily: 'Inter',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider(
                                                                      height:
                                                                      16.0,
                                                                      thickness:
                                                                      2.0,
                                                                      color: Color(
                                                                          0xFFF1F4F8),
                                                                    ),
                                                                    Text(
                                                                      simpleResultItem
                                                                          .postTitle,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .titleMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Inter Tight',
                                                                        letterSpacing:
                                                                        0.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      simpleResultItem
                                                                          .postDescription,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyLarge
                                                                          .override(
                                                                        fontFamily:
                                                                        'Inter',
                                                                        letterSpacing:
                                                                        0.0,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children:
                                                                        [
                                                                          Row(
                                                                            mainAxisSize:
                                                                            MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                            children:
                                                                            [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  if (simpleResultItem.like.contains(currentUserReference) != false)
                                                                                    Icon(
                                                                                      Icons.thumb_up_rounded,
                                                                                      color: Color(0xFFFF0000),
                                                                                      size: 24.0,
                                                                                    ),
                                                                                  if (simpleResultItem.like.contains(currentUserReference) == false)
                                                                                    Icon(
                                                                                      Icons.thumb_up_outlined,
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      size: 24.0,
                                                                                    ),
                                                                                  Text(
                                                                                    simpleResultItem.like.length.toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Inter',
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 4.0)),
                                                                              ),
                                                                            ].divide(SizedBox(width: 16.0)),
                                                                          ),
                                                                        ].divide(SizedBox(width: 20.0)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          } else {
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: StreamBuilder<
                                                      List<PostsRecord>>(
                                                    stream: queryPostsRecord(
                                                      queryBuilder:
                                                          (postsRecord) =>
                                                          postsRecord.orderBy(
                                                              'time_posted',
                                                              descending:
                                                              true),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                            CircularProgressIndicator(
                                                              valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<PostsRecord>
                                                      listViewPostsRecordList =
                                                      snapshot.data!;

                                                      return ListView.builder(
                                                        padding:
                                                        EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                        Axis.vertical,
                                                        itemCount:
                                                        listViewPostsRecordList
                                                            .length,
                                                        itemBuilder: (context,
                                                            listViewIndex) {
                                                          final listViewPostsRecord =
                                                          listViewPostsRecordList[
                                                          listViewIndex];
                                                          return Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                16.0,
                                                                4.0,
                                                                16.0,
                                                                8.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                              Colors
                                                                  .transparent,
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'DetailPost',
                                                                  queryParameters:
                                                                  {
                                                                    'postDetail':
                                                                    serializeParam(
                                                                      listViewPostsRecord,
                                                                      ParamType
                                                                          .Document,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    'postDetail':
                                                                    listViewPostsRecord,
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                      7.0,
                                                                      color: Color(
                                                                          0x2F1D2429),
                                                                      offset:
                                                                      Offset(
                                                                        0.0,
                                                                        3.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8.0),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      16.0,
                                                                      12.0,
                                                                      16.0,
                                                                      12.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                        Row(
                                                                          mainAxisSize:
                                                                          MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              listViewPostsRecord.tag,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Plus Jakarta Sans',
                                                                                color: Color(0xFF39D2C0),
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              listViewPostsRecord.author,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        height:
                                                                        16.0,
                                                                        thickness:
                                                                        2.0,
                                                                        color: Color(
                                                                            0xFFF1F4F8),
                                                                      ),
                                                                      Text(
                                                                        listViewPostsRecord
                                                                            .postTitle,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                          fontFamily: 'Inter Tight',
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        listViewPostsRecord
                                                                            .postDescription,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                          fontFamily: 'Inter',
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                        Row(
                                                                          mainAxisSize:
                                                                          MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                          children:
                                                                          [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    if (listViewPostsRecord.like.contains(currentUserReference) != false)
                                                                                      Icon(
                                                                                        Icons.thumb_up_rounded,
                                                                                        color: Color(0xFFFF0000),
                                                                                        size: 24.0,
                                                                                      ),
                                                                                    if (listViewPostsRecord.like.contains(currentUserReference) == false)
                                                                                      Icon(
                                                                                        Icons.thumb_up_outlined,
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        size: 24.0,
                                                                                      ),
                                                                                    Text(
                                                                                      listViewPostsRecord.like.length.toString(),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Inter',
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                ),
                                                                              ].divide(SizedBox(width: 16.0)),
                                                                            ),
                                                                          ].divide(SizedBox(width: 20.0)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: Color(0xFF747474),
                                            borderRadius: 30.0,
                                            borderWidth: 3.0,
                                            buttonSize: 60.0,
                                            fillColor: Colors.white,
                                            icon: Icon(
                                              Icons.desktop_windows,
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              size: 30.0,
                                            ),
                                            onPressed: RustDeskLauncher.launchRustDesk,
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderColor: Color(0xFF747474),
                                          borderRadius: 30.0,
                                          borderWidth: 3.0,
                                          buttonSize: 60.0,
                                          fillColor: Colors.white,
                                          icon: Icon(
                                            Icons.add_outlined,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            size: 40.0,
                                          ),
                                          onPressed: () async {
                                            context.pushNamed('CreatePost');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                              .height *
                                              0.7,
                                          child: Opacity(
                                            opacity: 0.9,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: wrapWithModel(
                                                model:
                                                _model.aiChatComponentModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                updateOnChange: true,
                                                child: AiChatComponentWidget(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
