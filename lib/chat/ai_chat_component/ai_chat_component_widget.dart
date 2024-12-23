import '/backend/api_requests/api_calls.dart';
import '/chat/empty_list/empty_list_widget.dart';
import '/chat/writing_indicator/writing_indicator_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ai_chat_component_model.dart';
export 'ai_chat_component_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AnimatedChatText extends StatefulWidget {
  final String fullText; // 출력할 전체 텍스트
  final Duration delay; // 글자 간 지연 시간
  final VoidCallback? onAnimationComplete; // 애니메이션 완료 콜백

  const AnimatedChatText({
    required this.fullText,
    this.delay = const Duration(milliseconds: 50),
    this.onAnimationComplete, // 추가
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedChatTextState createState() => _AnimatedChatTextState();
}

class _AnimatedChatTextState extends State<AnimatedChatText> {
  String displayedText = ""; // 현재 출력된 텍스트


  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }


  void _startTypingAnimation() async {
    for (int i = 0; i < widget.fullText.length; i++) {
      await Future.delayed(widget.delay); // 글자 간의 지연
      if (!mounted) return;
      setState(() {
        displayedText = widget.fullText.substring(0, i + 1);
      });
    }

    // 애니메이션 완료 시 콜백 호출
    widget.onAnimationComplete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
      ),
    );
  }
}

class AiChatComponentWidget extends StatefulWidget {
  const AiChatComponentWidget({super.key});

  @override
  State<AiChatComponentWidget> createState() => _AiChatComponentWidgetState();
}

class _AiChatComponentWidgetState extends State<AiChatComponentWidget> {
  late AiChatComponentModel _model;
  final stt.SpeechToText _speech = stt.SpeechToText();  // 추가
  bool _isListening = false; // 추가
  bool isAnimated = false; // 애니메이션 상태 제어 변수

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AiChatComponentModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _initSpeech();
  }

  // 음성인식 초기화 함수 추가
  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {});
    }
  }

  // 음성인식 시작/중지 함수 추가
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
            if (!_speech.isListening) {
              setState(() => _isListening = false);
            }
          },
          listenFor: Duration(seconds: 4),
          pauseFor: Duration(seconds: 4),
          localeId: 'ko_KR',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 770.0,
        ),
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Container(
                        width: 100.0,
                        height: 24.0,
                        decoration: const BoxDecoration(),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 12.0, 12.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 4.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent4,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment:
                                      const AlignmentDirectional(0.0, -1.0),
                                      child: Builder(
                                        builder: (context) {
                                          final chat =
                                              _model.chatHistory?.toList() ??
                                                  [];
                                          if (chat.isEmpty) {
                                            return const SizedBox(
                                              width: double.infinity,
                                              child: EmptyListWidget(),
                                            );
                                          }

                                          return ListView.builder(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              16.0,
                                            ),
                                            scrollDirection: Axis.vertical,
                                            itemCount: chat.length,
                                            itemBuilder: (context, chatIndex) {
                                              final chatItem = chat[chatIndex];
                                              final bool isLastItem = chatIndex == (_model.chatHistory?.length ?? 0) - 1;
                                              return Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    12.0, 12.0, 12.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    if ((int index) {
                                                      return index % 2 != 0;
                                                    }(chatIndex))
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Container(
                                                                constraints:
                                                                BoxConstraints(
                                                                  maxWidth: () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                        .width >=
                                                                        1170.0) {
                                                                      return 700.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                        .width <=
                                                                        470.0) {
                                                                      return 330.0;
                                                                    } else {
                                                                      return 530.0;
                                                                    }
                                                                  }(),
                                                                ),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primary,
                                                                  borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                    bottomLeft:
                                                                    Radius.circular(
                                                                        0.0),
                                                                    bottomRight:
                                                                    Radius.circular(
                                                                        12.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                        12.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                        12.0),
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .primary,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      12.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      SelectionArea(
                                                                        child: isLastItem && isAnimated
                                                                            ? AnimatedChatText(
                                                                          fullText: getJsonField(
                                                                            chatItem,
                                                                            r'''$['content']''',
                                                                          ).toString(),
                                                                          delay: const Duration(milliseconds: 50),
                                                                          onAnimationComplete: () {
                                                                            setState(() {
                                                                              isAnimated = true;
                                                                                });})
                                                                            : Text(
                                                                          getJsonField(
                                                                            chatItem,
                                                                            r'''$['content']''',
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            fontFamily: 'Inter',
                                                                            letterSpacing: 0.0,
                                                                            lineHeight: 1.5,
                                                                          ),
                                                                          overflow: TextOverflow.clip, // 오버플로우 방지
                                                                          softWrap: true, // 줄바꿈 활성화
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    2.0,
                                                                    0.0,
                                                                    0.0),
                                                                child: InkWell(
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
                                                                    await Clipboard.setData(
                                                                        ClipboardData(
                                                                            text:
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                chatItem,
                                                                                r'''$['content']''',
                                                                              )?.toString(),
                                                                              '--',
                                                                            )));
                                                                    ScaffoldMessenger.of(
                                                                        context)
                                                                        .showSnackBar(
                                                                      SnackBar(content: Text(
                                                                        '클립보드에 복사되었습니다!',
                                                                        style: TextStyle(
                                                                          color: Colors.black, // 글자색 설정
                                                                          fontSize: 14.0,
                                                                        ),
                                                                      ),
                                                                        backgroundColor:  Color(0xFFFAEDCD), // 배경색 설정
                                                                        behavior: SnackBarBehavior.floating, // 추가적으로 스낵바 동작 변경 (선택 사항)
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    const BoxDecoration(),
                                                                    child:
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          12.0,
                                                                          4.0),
                                                                      child:
                                                                      Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                4.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                            Icon(
                                                                              Icons.content_copy,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 12.0,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                4.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                            Text(
                                                                              '답변 복사하기',
                                                                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                fontFamily: 'Inter',
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    if (chatIndex % 2 == 0)
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Container(
                                                            constraints:
                                                            BoxConstraints(
                                                              maxWidth: () {
                                                                if (MediaQuery.sizeOf(
                                                                    context)
                                                                    .width >=
                                                                    1170.0) {
                                                                  return 700.0;
                                                                } else if (MediaQuery.sizeOf(
                                                                    context)
                                                                    .width <=
                                                                    470.0) {
                                                                  return 330.0;
                                                                } else {
                                                                  return 530.0;
                                                                }
                                                              }()
                                                            ),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                    12.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                    0.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                    12.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                    12.0),
                                                              ),
                                                              border:
                                                              Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .alternate,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  12.0,
                                                                  8.0,
                                                                  12.0,
                                                                  8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    getJsonField(
                                                                      chatItem,
                                                                      r'''$['content']''',
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Inter',
                                                                      letterSpacing:
                                                                      0.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              );
                                            },
                                            controller:
                                            _model.listViewController,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  if (_model.aiResponding == true)
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        wrapWithModel(
                                          model: _model.writingIndicatorModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: const WritingIndicatorWidget(),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Color(0x33000000),
                      offset: Offset(
                        0.0,
                        1.0,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '여기에 질문해주세요!',
                          hintStyle:
                          FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          errorStyle:
                          FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).error,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 24.0, 70.0, 24.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                        maxLines: 8,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator:
                        _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 음성인식 버튼 추가
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 50.0,
                            icon: Icon(
                              _model.isListening ? Icons.mic : Icons.mic_none,
                              color: _model.isListening
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).secondaryText,
                              size: 28.0,
                            ),
                            onPressed: _startListening,
                          ),
                          // 기존 전송 버튼
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            icon: Icon(
                              Icons.send_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 30.0,
                            ),
                            showLoadingIndicator: true,
                            onPressed: () async {
                              // addToChat_aiTyping

                              var chattext =_model.textController.text;
                              isAnimated = true;
                              _model.textController?.clear();
                              _model.aiResponding = true;
                              _model.chatHistory = functions.saveChatHistory(
                                  _model.chatHistory,
                                  functions
                                      .convertToJSON(chattext));
                              safeSetState(() {});

                              // The "chatHistory" is the generated JSON -- we send the whole chat history to AI in order for it to understand context.
                              _model.chatGPTResponse =
                              await OpenAIChatGPTGroup.sendFullPromptCall.call(
                                  apiKey: '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',
                                  promptJson: [
                                    {"role": "system", "content": "답변은 간단하게 하는데 필요에 따라 길게 해도 됩니다. 그러나 200자를 넘기지 않는 방향으로 답변하세요. 정확 하지 않은 답변은 절대 하지말고 차라리 모른다고 하세요. 그리고 공백으로 질문하거나 질문의 의도가 헷갈리면 '무엇이든 물어보세요' 라고 대답해"},
                                    ..._model.chatHistory
                                  ]
                              );
                              if ((_model.chatGPTResponse?.succeeded ?? true)) {
                                _model.aiResponding = false;
                                final responseJson = _model.chatGPTResponse?.jsonBody;
                                print('API Response: $responseJson'); // 디버깅
                                print('API Response: $responseJson'); //


                                final rawMessage = getJsonField(
                                  responseJson,
                                  r'''$['choices'][0]['message']''',
                                );

                                dynamic chatResponse;
                                if (rawMessage != null) {
                                  try {
                                    if (rawMessage is Map) {
                                      chatResponse = {
                                        ...rawMessage,
                                        'content': utf8.decode(rawMessage['content'].toString().runes.toList()),
                                      };
                                    } else {
                                      chatResponse = utf8.decode(rawMessage.toString().runes.toList());
                                    }
                                  } catch (e) {
                                    print('Decoding error: $e');
                                    chatResponse = rawMessage;
                                  }
                                } else {
                                  chatResponse = {'error': 'AI 응답을 가져오는 데 실패했습니다.'};
                                }

                                // chatHistory에 chatResponse 추가
                                _model.chatHistory = functions.saveChatHistory(
                                  _model.chatHistory,
                                  chatResponse,
                                );

                                safeSetState(() {});
                                safeSetState(() {
                                  _model.textController?.clear();
                                });

                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Your API Call Failed!',
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Inter Tight',
                                        color:
                                        FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                    FlutterFlowTheme.of(context).error,
                                  ),
                                );
                                _model.aiResponding = false;
                                safeSetState(() {});
                              }

                              await Future.delayed(
                                  const Duration(milliseconds: 800));
                              await _model.listViewController?.animateTo(
                                _model.listViewController!.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.ease,
                              );

                              safeSetState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              Container(
                width: 100.0,
                height: 60.0,
                decoration: const BoxDecoration(),
              ),
          ],
        ),
      ),
    );
  }
}