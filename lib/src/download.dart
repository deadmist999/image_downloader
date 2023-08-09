import 'dart:convert';
import 'dart:html';

void download(List<int> bytes, String downloadName) {
  final base64 = base64Encode(bytes);
  final anchor =
  AnchorElement(href: 'data:application/octet-stream;base64,$base64')
    ..target = 'blank';
  anchor.download = downloadName;
  document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
