import 'dart:html' as html;
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RustDeskLauncher {
  static Future<void> launchRustDesk() async {
    if (kIsWeb) {
      try {
        // 웹에서 RustDesk 프로토콜 실행 시도
        html.window.open('rustdesk://', '_blank');

        // 실행 실패 시를 대비해 잠시 후 다운로드 페이지도 열기
        await Future.delayed(Duration(seconds: 5));
        final downloadUrl = Uri.parse('https://rustdesk.com/');
        if (!await launchUrl(downloadUrl, mode: LaunchMode.externalApplication)) {
          throw Exception('Failed to open download page');
        }
      } catch (e) {
        print('Error launching RustDesk: $e');
        // 에러 발생시 다운로드 페이지로 이동
        final url = Uri.parse('https://rustdesk.com/');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch website');
        }
      }
    } else if (Platform.isAndroid) {
      try {
        // Android에서 RustDesk 실행 시도
        final rustDeskUrl = Uri.parse('rustdesk://');
        final canLaunch = await canLaunchUrl(rustDeskUrl);

        if (canLaunch) {
          // 앱이 설치되어 있으면 실행
          await launchUrl(rustDeskUrl);
        } else {
          // 설치되어 있지 않으면 다운로드 페이지로 이동
          final downloadUrl = Uri.parse('https://rustdesk.com/');
          await launchUrl(downloadUrl, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        print('Error launching RustDesk on Android: $e');
        final url = Uri.parse('https://rustdesk.com/');
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } else {
      // 기타 플랫폼
      final url = Uri.parse('https://rustdesk.com/');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch website');
      }
    }
  }
}