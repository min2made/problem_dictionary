import 'dart:html' as html;

class UrlProtocol {
  static void openProtocol(String url, String target) {
    html.window.open(url, target);
  }
}