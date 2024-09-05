// import 'package:drift/drift.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/basic.dart' as p;
// import 'package:hb_demo/features/database.dart';
// import 'package:hb_demo/features/feature/employeeTableHelper.dart';

// class EmployeeScreen extends StatefulWidget {
//   final DBHelper dbHelper;

//   EmployeeScreen({required this.dbHelper});

//   @override
//   _EmployeeScreenState createState() => _EmployeeScreenState();
// }

// class _EmployeeScreenState extends State<EmployeeScreen> {
//   late Future<List<Employee>> employeeList;

//   @override
//   void initState() {
//     super.initState();
//     _refreshEmployeeList();
//   }

//   void _refreshEmployeeList() {
//     setState(() {
//       employeeList = widget.dbHelper.getAllEmployees();
//     });
//   }

//   void _addEmployee(String name, String post, int salary) async {
//     await widget.dbHelper.addEmployee(EmployeesCompanion(
//       name: Value(name),
//       post: Value(post),
//       salary: Value(salary),
//       department: const Value("IT"),
//     ));
//     _refreshEmployeeList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Employee List'),
//       ),
//       body: FutureBuilder<List<Employee>>(
//         future: employeeList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No employees found'));
//           }

//           final employees = snapshot.data!;

//           return ListView.builder(
//             itemCount: employees.length,
//             itemBuilder: (context, index) {
//               final employee = employees[index];
//               return ListTile(
//                 title: Text(employee.name ?? 'No Name'),
//                 subtitle: Text('Post: ${employee.post ?? 'No Post'}'),
//                 trailing: Text('Salary: ${employee.salary ?? 0}'),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddEmployeeDialog(context),
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _showAddEmployeeDialog(BuildContext context) {
//     final nameController = TextEditingController();
//     final postController = TextEditingController();
//     final salaryController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Employee'),
//           content: p.Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: postController,
//                 decoration: InputDecoration(labelText: 'Post'),
//               ),
//               TextField(
//                 controller: salaryController,
//                 decoration: InputDecoration(labelText: 'Salary'),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final name = nameController.text;
//                 final post = postController.text;
//                 final salary = int.tryParse(salaryController.text) ?? 0;

//                 _addEmployee(name, post, salary);

//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
