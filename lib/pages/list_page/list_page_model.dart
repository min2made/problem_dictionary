import '/backend/backend.dart';
import '/chat/ai_chat_component/ai_chat_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_page_widget.dart' show ListPageWidget;
import 'package:flutter/material.dart';

class ListPageModel extends FlutterFlowModel<ListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<PostsRecord> simpleSearchResults = [];
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for aiChat_Component component.
  late AiChatComponentModel aiChatComponentModel;

  @override
  void initState(BuildContext context) {
    aiChatComponentModel = createModel(context, () => AiChatComponentModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    tabBarController?.dispose();
    aiChatComponentModel.dispose();
  }
}
