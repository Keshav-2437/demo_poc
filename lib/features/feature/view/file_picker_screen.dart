import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../crashlytics_impl.dart';
import '../viewModel/file_picker_vm.dart';
import 'api_call_screen.dart';
import 'chart_screen.dart';
import 'pdf_file_view.dart';
import 'test_screen.dart';

class FilePickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filePickVM = GetIt.I<FilePickVM>();
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

    return Scaffold(
      appBar: AppBar(title: Text('File Picker')),
      body: ValueListenableBuilder<FilePickState>(
        valueListenable: filePickVM,
        builder: (context, state, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => filePickVM.pickFile(),
                child: Text('Pick a File'),
              ),
              if (state.selectedFileName != null)
                Text('Selected file: ${state.selectedFileName}'),
              if (state.selectedFilePath != null && !kIsWeb)
                Text('File path: ${state.selectedFilePath}'),
              if (state.selectedFileBytes != null)
                Text('File size: ${state.selectedFileBytes?.length} bytes'),
              if (state.selectedFilePath == null &&
                  state.selectedFileBytes != null &&
                  kIsWeb)
                Text(
                    'On web, file size: ${state.selectedFileBytes?.length} bytes'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LineChartScreen()),
                  );
                },
                child: Text('Charts'),
              ),
              ElevatedButton(
                onPressed: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => _buildBottomSheet(context),
                  );
                },
                child: Text('Bottom sheet'),
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    throw Exception('Test Crash'); // Simulate a crash
                  } catch (e, stackTrace) {
                    CrashlyticsService.recordError(e, stackTrace);
                  }
                },
                child: Text('Record crash'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApiCallScreen()),
                    );
                  },
                  child: Text('Api call')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PdfViewerPage()),
                    );
                  },
                  child: Text('pdf-file view')),
              ElevatedButton(
                  onPressed: () async {
                    await _analytics.logEvent(
                      name: 'button_pressed',
                      parameters: {'button_name': 'example_button'},
                    );
                  },
                  child: Text('log event')),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestScreen()),
                    );
                  },
                  child: Text('Test screen'))
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Modal Bottom Sheet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('bottom sheet.'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
