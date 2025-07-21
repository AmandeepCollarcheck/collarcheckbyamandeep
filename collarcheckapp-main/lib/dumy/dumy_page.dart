import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dumy_controllers.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabControllerX>(
      init: TabControllerX(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Auto Tab Selector with GetX'),
            bottom: TabBar(
              controller: TabController(
                length: 3,
                vsync: ScaffoldState(), // vsync is required for TabController
              ),
              onTap: (index) {
                // Update tab index in controller when tab is manually selected
                controller.updateTabIndex(index);
              },
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
            ),
          ),
          body: Column(
            children: [
              // Scrolling content with ScrollController
              Expanded(
                child: TabBarView(
                  controller: TabController(
                    length: 3,
                    vsync: ScaffoldState(), // vsync is required for TabController
                  ),
                  children: [
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: List.generate(30, (index) {
                          return ListTile(
                            title: Text('Item in Tab 1: $index'),
                          );
                        }),
                      ),
                    ),
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: List.generate(30, (index) {
                          return ListTile(
                            title: Text('Item in Tab 2: $index'),
                          );
                        }),
                      ),
                    ),
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: List.generate(30, (index) {
                          return ListTile(
                            title: Text('Item in Tab 3: $index'),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}