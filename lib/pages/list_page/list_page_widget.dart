import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/ai_chat_component/ai_chat_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
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
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ListPageWidget extends StatefulWidget {
  const ListPageWidget({super.key});

  @override
  State<ListPageWidget> createState() => _ListPageWidgetState();
}

class _ListPageWidgetState extends State<ListPageWidget>
    with TickerProviderStateMixin {
  late ListPageModel _model;
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListPageModel());
    _initSpeech();

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {});
    }
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _model.textController?.text = result.recognizedWords;
            });

            // 음성 인식이 끝나면 (말하기를 멈추면) 자동으로 검색 실행
            if (!_speech.isListening) {
              setState(() => _isListening = false);

              // 검색 실행
              EasyDebounce.debounce(
                '_model.textController',
                Duration(milliseconds: 2000),
                    () async {
                  await queryPostsRecordOnce()
                      .then(
                        (records) => _model.simpleSearchResults = TextSearch(
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
                        .search(_model.textController!.text)
                        .map((r) => r.object)
                        .toList(),
                  )
                      .onError((_, __) => _model.simpleSearchResults = [])
                      .whenComplete(() => safeSetState(() {}));
                },
              );
            }
          },
          listenFor: Duration(seconds: 3), // 5초간 음성 인식 후 자동 중지
          pauseFor: Duration(seconds: 3),  // 3초간 말하지 않으면 인식 중지
          onSoundLevelChange: (level) {
            // 소리 레벨이 변경될 때마다 호출
            // 여기서 사용자가 말하고 있는지 체크할 수 있음
          },
          cancelOnError: true,
          partialResults: true,
          localeId: 'ko_KR', // 한국어로 설정
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 12.0),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 12.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.textController',
                                    Duration(milliseconds: 2000),
                                        () async {
                                      await queryPostsRecordOnce()
                                          .then(
                                            (records) =>
                                        _model.simpleSearchResults =
                                            TextSearch(
                                              records
                                                  .map(
                                                    (record) => TextSearchItem
                                                    .fromTerms(record, [
                                                  record.postTitle!,
                                                  record.postDescription!,
                                                  record.tag!
                                                ]),
                                              )
                                                  .toList(),
                                            )
                                                .search(_model
                                                .textController
                                                .text)
                                                .map((r) => r.object)
                                                .toList(),
                                      )
                                          .onError((_, __) =>
                                      _model.simpleSearchResults = [])
                                          .whenComplete(
                                              () => safeSetState(() {}));
                                    },
                                  ),
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '검색...',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                                  cursorColor:
                                  FlutterFlowTheme.of(context).primary,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: _isListening
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                            ),
                            onPressed: _startListening,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child:
                                      StreamBuilder<List<DictionsRecord>>(
                                        stream: queryDictionsRecord(),
                                        builder: (context, snapshot) {
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
                                                    FlutterFlowTheme.of(context)
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
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                            listViewDictionsRecordList
                                                .length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewDictionsRecord =
                                              listViewDictionsRecordList[
                                              listViewIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    16.0, 4.0, 16.0, 4.0),
                                                child: InkWell(
                                                  splashColor:
                                                  Colors.transparent,
                                                  focusColor:
                                                  Colors.transparent,
                                                  hoverColor:
                                                  Colors.transparent,
                                                  highlightColor:
                                                  Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'DetailDiction',
                                                      queryParameters: {
                                                        'dictionDetails':
                                                        serializeParam(
                                                          listViewDictionsRecord,
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'dictionDetails':
                                                        listViewDictionsRecord,
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 7.0,
                                                          color:
                                                          Color(0x2F1D2429),
                                                          offset: Offset(
                                                            0.0,
                                                            3.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16.0,
                                                          12.0,
                                                          16.0,
                                                          12.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                10.0,
                                                                0.0,
                                                                0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  listViewDictionsRecord
                                                                      .postTitle,
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
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 16.0,
                                                            thickness: 2.0,
                                                            color: Color(
                                                                0xFFF1F4F8),
                                                          ),
                                                          Text(
                                                            listViewDictionsRecord
                                                                .postDescription,
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyLarge
                                                                .override(
                                                              fontFamily:
                                                              'Inter',
                                                              letterSpacing:
                                                              0.0,
                                                            ),
                                                          ),
                                                          Builder(
                                                            builder: (context) {
                                                              final dictionImgs =
                                                              listViewDictionsRecord
                                                                  .postMultiplePhotos
                                                                  .map(
                                                                      (e) =>
                                                                  e)
                                                                  .toList();

                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                Axis.horizontal,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  children: List.generate(
                                                                      dictionImgs
                                                                          .length,
                                                                          (dictionImgsIndex) {
                                                                        final dictionImgsItem =
                                                                        dictionImgs[
                                                                        dictionImgsIndex];
                                                                        return Visibility(
                                                                          visible: dictionImgsItem !=
                                                                              null &&
                                                                              dictionImgsItem !=
                                                                                  '',
                                                                          child:
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                            ClipRRect(
                                                                              borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                              child:
                                                                              Image.network(
                                                                                dictionImgsItem,
                                                                                width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                                height:
                                                                                200.0,
                                                                                fit:
                                                                                BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                ),
                                                              );
                                                            },
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
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 15.0, 10.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Color(0xFF747474),
                                      borderRadius: 30.0,
                                      borderWidth: 3.0,
                                      buttonSize: 60.0,
                                      fillColor: Colors.white,
                                      icon: Icon(
                                        Icons.settings_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 30.0,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed('ChangeProflie');
                                      },
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
                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          if (_model
                                              .simpleSearchResults.isNotEmpty) {
                                            return Builder(
                                              builder: (context) {
                                                final searchResults = _model
                                                    .simpleSearchResults
                                                    .toList();

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  itemCount:
                                                  searchResults.length,
                                                  itemBuilder: (context,
                                                      searchResultsIndex) {
                                                    final searchResultsItem =
                                                    searchResults[
                                                    searchResultsIndex];
                                                    return Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16.0,
                                                          0.0,
                                                          16.0,
                                                          0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 7.0,
                                                              color: Color(
                                                                  0x2F1D2429),
                                                              offset: Offset(
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
                                                          padding:
                                                          EdgeInsetsDirectional
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
                                                              Text(
                                                                searchResultsItem
                                                                    .tag,
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: Color(
                                                                      0xFF39D2C0),
                                                                  fontSize:
                                                                  14.0,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 16.0,
                                                                thickness: 2.0,
                                                                color: Color(
                                                                    0xFFF1F4F8),
                                                              ),
                                                              Text(
                                                                searchResultsItem
                                                                    .postTitle,
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyLarge
                                                                    .override(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  color: Color(
                                                                      0xFF14181B),
                                                                  fontSize:
                                                                  16.0,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                                child: Text(
                                                                  searchResultsItem
                                                                      .postDescription,
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .labelMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                    color: Color(
                                                                        0xFF57636C),
                                                                    fontSize:
                                                                    14.0,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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
                                                                4.0),
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                          fontFamily: 'Inter',
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                      ),
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final images = listViewPostsRecord
                                                                              .postMutiplePhotos
                                                                              .map((e) => e)
                                                                              .toList();

                                                                          return SingleChildScrollView(
                                                                            scrollDirection:
                                                                            Axis.horizontal,
                                                                            child:
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: List.generate(images.length, (imagesIndex) {
                                                                                final imagesItem = images[imagesIndex];
                                                                                return Visibility(
                                                                                  visible: imagesItem != null && imagesItem != '',
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      child: Image.network(
                                                                                        imagesItem,
                                                                                        width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                        height: 200.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            ),
                                                                          );
                                                                        },
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
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    ToggleIcon(
                                                                                      onPressed: () async {
                                                                                        final likeElement = currentUserReference;
                                                                                        final likeUpdate = listViewPostsRecord.like.contains(likeElement) ? FieldValue.arrayRemove([likeElement]) : FieldValue.arrayUnion([likeElement]);
                                                                                        await listViewPostsRecord.reference.update({
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'like': likeUpdate,
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                      },
                                                                                      value: listViewPostsRecord.like.contains(currentUserReference),
                                                                                      onIcon: Icon(
                                                                                        Icons.thumb_up_rounded,
                                                                                        color: Color(0xFFFF0000),
                                                                                        size: 24.0,
                                                                                      ),
                                                                                      offIcon: Icon(
                                                                                        Icons.thumb_up_outlined,
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        size: 24.0,
                                                                                      ),
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
                                                                                ToggleIcon(
                                                                                  onPressed: () async {
                                                                                    final dislikeElement = currentUserReference;
                                                                                    final dislikeUpdate = listViewPostsRecord.dislike.contains(dislikeElement) ? FieldValue.arrayRemove([dislikeElement]) : FieldValue.arrayUnion([dislikeElement]);
                                                                                    await listViewPostsRecord.reference.update({
                                                                                      ...mapToFirestore(
                                                                                        {
                                                                                          'dislike': dislikeUpdate,
                                                                                        },
                                                                                      ),
                                                                                    });
                                                                                  },
                                                                                  value: listViewPostsRecord.dislike.contains(currentUserReference),
                                                                                  onIcon: Icon(
                                                                                    Icons.thumb_down_rounded,
                                                                                    color: Color(0xFF0B00FF),
                                                                                    size: 24.0,
                                                                                  ),
                                                                                  offIcon: Icon(
                                                                                    Icons.thumb_down_outlined,
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  listViewPostsRecord.dislike.length.toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 16.0)),
                                                                            ),
                                                                            Text(
                                                                              valueOrDefault<String>(
                                                                                listViewPostsRecord.timePosted?.toString(),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 15.0, 10.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Color(0xFF747474),
                                      borderRadius: 3.0,
                                      borderWidth: 3.0,
                                      buttonSize: 60.0,
                                      fillColor: Colors.white,
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 30.0,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed('CreatePost');
                                      },
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
