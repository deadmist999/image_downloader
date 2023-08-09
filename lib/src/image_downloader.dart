import 'dart:io';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';

import 'empty_download.dart' if (dart.library.html) 'download.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;


  Future<void> saveImage(String url) async {
    final imageName =
        DateTime.now().millisecondsSinceEpoch.toString() + url.split('/').last;
    if (kIsWeb) {
      download(url.codeUnits, imageName);
      return;
    }
    final http.Response response = await http.get(Uri.parse(url));
    final dir = await getTemporaryDirectory();
    final filename = '${dir.path}$imageName';
    final file = File(filename);
    await file.writeAsBytes(response.bodyBytes);
    final params = SaveFileDialogParams(
      sourceFilePath: file.path,
      fileName: imageName,
    );

    final finalPath = FlutterFileDialog.saveFile(params: params);
  }
