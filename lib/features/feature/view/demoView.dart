import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../viewModel/demoVM.dart';
import 'storedItemsScreen.dart';

class ResponsiveScreen extends StatelessWidget {
  final ViewModel viewModel = ViewModel();
  final Trace loadTimeTrace;

  ResponsiveScreen({required this.loadTimeTrace});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 650;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadTimeTrace.stop();
    });

    final Map<String, dynamic> leftWidget = viewModel.bottomWidgets.first;
    final List<Map<String, dynamic>> rightWidgets =
        viewModel.bottomWidgets.sublist(1);

    Widget buildWidget(Map<String, dynamic> widget, {bool showText = true}) {
      return InkWell(
        onTap: () async {
          await viewModel.saveToSharedPreferences(
              widget['text'], widget['text']);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(widget['image'], width: 24, height: 24),
              if (showText && widget['text'] != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget['text'],
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    Widget buildMobileWidget(Map<String, dynamic> widget) {
      return InkWell(
        onTap: () async {
          await viewModel.saveToSharedPreferences(
              widget['text'], widget['text']);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(widget['image'], width: 24, height: 24),
              if (widget['text'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    widget['text'],
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: isDesktop ? null : buildWidget(leftWidget, showText: true),
        actions: [
          if (isDesktop) buildWidget(leftWidget, showText: true),
          Spacer(),
          Row(
            children: rightWidgets.map((widget) {
              return buildWidget(
                widget,
                showText: isDesktop,
              );
            }).toList(),
          ),
        ],
        toolbarHeight: 60,
      ),
      body: Row(
        children: [
          if (isDesktop)
            Container(
              width: 200,
              color: Colors.grey[200],
              child: ListView(
                padding: EdgeInsets.zero,
                children: viewModel.bottomWidgets.map((widget) {
                  return buildWidget(widget);
                }).toList(),
              ),
            ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: isDesktop ? 150 : 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.banners.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: SvgPicture.asset(
                        //   viewModel.banners[index],
                        //   width: isDesktop ? 300 : 150,
                        // ),
                        child: Container(),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 2 : 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: isDesktop ? 2 : 1.5,
                    ),
                    itemCount: viewModel.gridItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.gridItems[index];
                      return InkWell(
                        onTap: () async {
                          // Perform Db insert operation
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Image.asset(item['image']),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(item['desc']),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          item['star'],
                                          width: isDesktop ? 16 : 12,
                                          height: isDesktop ? 16 : 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            item['rating'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoredItemsScreen(viewModel: viewModel)),
          );
        },
        child: Icon(Icons.view_list),
      ),
      bottomNavigationBar: !isDesktop
          ? SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.bottomWidgets.length,
                itemBuilder: (context, index) {
                  final widget = viewModel.bottomWidgets[index];
                  return buildMobileWidget(widget);
                },
              ),
            )
          : null,
    );
  }
}
