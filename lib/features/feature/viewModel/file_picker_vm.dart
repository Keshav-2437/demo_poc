import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class FilePickVM extends ValueNotifier<FilePickState> {
  FilePickVM() : super(FilePickState());

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.first;
      final bytes = file.bytes;
      final filePath = kIsWeb ? null : file.path; // path is null on web

      value = FilePickState(
        selectedFileName: file.name,
        selectedFilePath: filePath,
        selectedFileBytes: bytes,
      );
    } else {
      value = FilePickState();
    }
  }
}

class FilePickState {
  final String? selectedFileName;
  final String? selectedFilePath;
  final Uint8List? selectedFileBytes;

  FilePickState({
    this.selectedFileName,
    this.selectedFilePath,
    this.selectedFileBytes,
  });
}
