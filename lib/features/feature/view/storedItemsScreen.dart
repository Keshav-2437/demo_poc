import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database.dart';
import '../employeeTableHelper.dart';
import '../viewModel/demoVM.dart';
import '../viewModel/file_picker_vm.dart';
import 'employee_acreen.dart';
import 'file_picker_screen.dart';

class StoredItemsScreen extends StatelessWidget {
  final ViewModel viewModel;

  StoredItemsScreen({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // final dbItems = viewModel.getAllFromDatabase();
    final prefItems = viewModel.getAllFromSharedPreferences();
    // final AppDb appDb = AppDb();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Items'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Text('Stored in Database:'),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => FilePickVM(),
                    child: FilePickerScreen(),
                  ),
                ),
              );
            },
          ),
          Divider(),
          InkWell(
            child: Text('Stored in SharedPreferences:'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           EmployeeScreen(dbHelper: DBHelper(appDb))),
              // );
            },
          ),
          FutureBuilder<Map<String, String>>(
            future: prefItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              final items = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final key = items.keys.elementAt(index);
                    final value = items[key]!;
                    return ListTile(
                      title: Text(key),
                      subtitle: Text(value),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
