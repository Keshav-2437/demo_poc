import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HungerBox'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.location_city)),
          IconButton(onPressed: () {}, icon: Icon(Icons.business)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menu')),
            ListTile(title: Text('Dashboard'), onTap: () {}),
            ListTile(title: Text('Devices'), onTap: () {}),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Peripheral Devices',
                            style: Theme.of(context).textTheme.headlineLarge),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Peripheral Device Reference',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Hungerbox Reference',
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text('Apply')),
                            SizedBox(width: 8),
                            OutlinedButton(
                                onPressed: () {}, child: Text('Reset')),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text('Register New Device')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Device Reference')),
                        DataColumn(label: Text('Manufacturer')),
                        DataColumn(label: Text('Hungerbox Reference')),
                        DataColumn(label: Text('Merchant Reference')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: _buildRows(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text('Peripheral Devices',
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Peripheral Device Reference',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hungerbox Reference',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Apply')),
                    SizedBox(width: 8),
                    OutlinedButton(onPressed: () {}, child: Text('Reset')),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {}, child: Text('Register New Device')),
                SizedBox(height: 16),
                ..._buildMobileCards(),
              ],
            );
          }
        },
      ),
    );
  }

  List<DataRow> _buildRows() {
    return List<DataRow>.generate(5, (index) {
      return DataRow(cells: [
        DataCell(Text('F123...${index}')),
        DataCell(Text('Pine Labs')),
        DataCell(Text('Pi_b7')),
        DataCell(Text('1234')),
        DataCell(Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
          ],
        )),
      ]);
    });
  }

  List<Widget> _buildMobileCards() {
    return List<Widget>.generate(5, (index) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Device Reference: F123...${index}'),
              Text('Manufacturer: Pine Labs'),
              Text('Hungerbox Reference: Pi_b7'),
              Text('Merchant Reference: 1234'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
