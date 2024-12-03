import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'url_protocol.dart' if (dart.library.html) 'url_protocol_web.dart';

class RustDeskLauncher {
  static Future<void> launchRustDesk() async {
    if (kIsWeb) {
      try {
        UrlProtocol.openProtocol('rustdesk://', '_blank');
        await Future.delayed(Duration(seconds: 5));
        final downloadUrl = Uri.parse('https://rustdesk.com/');
        if (!await launchUrl(downloadUrl, mode: LaunchMode.externalApplication)) {
          throw Exception('Failed to open download page');
        }
      } catch (e) {
        print('Error launching RustDesk: $e');
        final url = Uri.parse('https://rustdesk.com/');
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch website');
        }
      }
    } else if (Platform.isAndroid) {
      try {
        final rustDeskUrl = Uri.parse('rustdesk://');
        final canLaunch = await canLaunchUrl(rustDeskUrl);

        if (canLaunch) {
          await launchUrl(rustDeskUrl);
        } else {
          final downloadUrl = Uri.parse('https://rustdesk.com/');
          await launchUrl(downloadUrl, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        print('Error launching RustDesk on Android: $e');
        final url = Uri.parse('https://rustdesk.com/');
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } else {
      final url = Uri.parse('https://rustdesk.com/');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch website');
      }
    }
  }
}