import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'change_proflie_model.dart';
export 'change_proflie_model.dart';

class ChangeProflieWidget extends StatefulWidget {
  const ChangeProflieWidget({super.key});

  @override
  State<ChangeProflieWidget> createState() => _ChangeProflieWidgetState();
}

class _ChangeProflieWidgetState extends State<ChangeProflieWidget> {
  late ChangeProflieModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangeProflieModel());

    _model.yourNameTextController ??= TextEditingController();
    _model.yourNameFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 14.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 50.0,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '프로필 수정하기',
                      style:
                      FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0.0,
        ),
      ),
      body: SafeArea(
        top: true,
        child: Form(
          key: _model.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                            context: context,
                            imageQuality: 80,
                            allowPhoto: true,
                            backgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            textColor: FlutterFlowTheme.of(context).primaryText,
                            pickerFontFamily: 'Outfit',
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            safeSetState(() => _model.isDataUploading1 = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];

                            var downloadUrls = <String>[];
                            try {
                              showUploadMessage(
                                context,
                                'Uploading file...',
                                showLoading: true,
                              );
                              selectedUploadedFiles = selectedMedia
                                  .map((m) => FFUploadedFile(
                                name: m.storagePath.split('/').last,
                                bytes: m.bytes,
                                height: m.dimensions?.height,
                                width: m.dimensions?.width,
                                blurHash: m.blurHash,
                              ))
                                  .toList();

                              downloadUrls = (await Future.wait(
                                selectedMedia.map(
                                      (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                                ),
                              ))
                                  .where((u) => u != null)
                                  .map((u) => u!)
                                  .toList();
                            } finally {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              _model.isDataUploading1 = false;
                            }
                            if (selectedUploadedFiles.length ==
                                selectedMedia.length &&
                                downloadUrls.length == selectedMedia.length) {
                              safeSetState(() {
                                _model.uploadedLocalFile1 =
                                    selectedUploadedFiles.first;
                                _model.uploadedFileUrl1 = downloadUrls.first;
                              });
                              showUploadMessage(context, 'Success!');
                            } else {
                              safeSetState(() {});
                              showUploadMessage(
                                  context, 'Failed to upload data');
                              return;
                            }
                          }
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: StreamBuilder<List<UsersRecord>>(
                              stream: queryUsersRecord(
                                singleRecord: true,
                              ),
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
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<UsersRecord> circleImageUsersRecordList =
                                snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final circleImageUsersRecord =
                                circleImageUsersRecordList.isNotEmpty
                                    ? circleImageUsersRecordList.first
                                    : null;

                                return Container(
                                  width: 90.0,
                                  height: 90.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration:
                                    Duration(milliseconds: 500),
                                    imageUrl: _model.uploadedFileUrl2 == null ||
                                        _model.uploadedFileUrl2 == ''
                                        ? (currentUserPhoto == null || currentUserPhoto == ''
                                        ? 'https://i.ibb.co/vV93kgy/35cf059d31c96e31aaf0a5326ad513d2.jpg'
                                        : currentUserPhoto)
                                        : _model.uploadedFileUrl2,
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                          context: context,
                          allowPhoto: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          safeSetState(() => _model.isDataUploading2 = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          var downloadUrls = <String>[];
                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                              height: m.dimensions?.height,
                              width: m.dimensions?.width,
                              blurHash: m.blurHash,
                            ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                    (m) async =>
                                await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            _model.isDataUploading2 = false;
                          }
                          if (selectedUploadedFiles.length ==
                              selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            safeSetState(() {
                              _model.uploadedLocalFile2 =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl2 = downloadUrls.first;
                            });
                          } else {
                            safeSetState(() {});
                            return;
                          }
                        }

                        await currentUserReference!
                            .update(createUsersRecordData(
                          photoUrl: _model.uploadedFileUrl2,
                        ));
                      },
                      text: '이미지 수정하기',
                      options: FFButtonOptions(
                        width: 200.0,
                        height: 50.0,
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                          fontFamily: 'Inter Tight',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                        ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 16.0,
                  thickness: 2.0,
                  color: Color(0xFFF1F4F8),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                  child: StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(
                      singleRecord: true,
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
                      List<UsersRecord> yourNameUsersRecordList =
                      snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final yourNameUsersRecord =
                      yourNameUsersRecordList.isNotEmpty
                          ? yourNameUsersRecordList.first
                          : null;

                      return TextFormField(
                        controller: _model.yourNameTextController,
                        focusNode: _model.yourNameFocusNode,
                        textCapitalization: TextCapitalization.words,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: '닉네임 입력하기...',
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 24.0, 0.0, 24.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        buildCounter: (context,
                            {required currentLength,
                              required isFocused,
                              maxLength}) =>
                        null,
                        validator: _model.yourNameTextControllerValidator
                            .asValidator(context),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }

                        try {
                          await currentUserReference!
                              .update(createUsersRecordData(
                            displayName: _model.yourNameTextController.text,
                          ));

                          // 수정 완료 후 알림 메시지 표시
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('닉네임이 수정되었습니다!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (e) {
                          // 수정 실패 시 알림 메시지 표시
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('수정에 실패했습니다. 다시 시도해주세요.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      text: '닉네임 수정하기',
                      options: FFButtonOptions(
                        width: 270.0,
                        height: 50.0,
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                          fontFamily: 'Inter Tight',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                        ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 16.0,
                  thickness: 2.0,
                  color: Color(0xFFF1F4F8),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();

                      context.goNamedAuth('StartPage', context.mounted);
                    },
                    text: '로그아웃',
                    options: FFButtonOptions(
                      width: 270.0,
                      height: 50.0,
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFFFB848A),
                      textStyle:
                      FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        letterSpacing: 0.0,
                      ),
                      elevation: 2.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
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
