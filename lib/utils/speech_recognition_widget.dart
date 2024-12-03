import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:easy_debounce/easy_debounce.dart';

class SpeechRecognitionWidget extends StatefulWidget {
  final TextEditingController? textController;
  final Function() onSearch;  // 검색 함수

  const SpeechRecognitionWidget({
    Key? key,
    required this.textController,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SpeechRecognitionWidget> createState() => _SpeechRecognitionWidgetState();
}

class _SpeechRecognitionWidgetState extends State<SpeechRecognitionWidget> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initializeSpeechRecognition();
  }

  Future<void> initializeSpeechRecognition() async {
    await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          setState(() => _isListening = false);
        }
      },
      onError: (errorNotification) {
        setState(() => _isListening = false);
        print('Error: $errorNotification');
      },
    );
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              widget.textController?.text = result.recognizedWords;
            });

            // 음성 인식이 끝나면 검색 실행
            if (!_speech.isListening) {
              setState(() => _isListening = false);
              // 검색 실행
              EasyDebounce.debounce(
                'speech_search',
                Duration(milliseconds: 2000),
                widget.onSearch,
              );
            }
          },
          listenFor: Duration(seconds: 3), // 3초간 음성 인식 후 자동 중지
          pauseFor: Duration(seconds: 3),  // 3초간 말하지 않으면 인식 중지
          localeId: 'ko_KR', // 한국어로 설정
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isListening ? Icons.mic : Icons.mic_none,
        color: _isListening ? Colors.red : Colors.grey,
      ),
      onPressed: _startListening,
    );
  }
}