import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dumy_controllers.dart';


class TabSyncNestedScrollPage extends StatelessWidget {
  final TabScrollController controller = Get.put(TabScrollController(), permanent: true);
  final List<String> tabs = ["Tab 1", "Tab 2", "Tab 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://placekitten.com/800/400',
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Obx(() => TabBar(
                controller: controller.tabController,  // Use the controller's TabController
                isScrollable: true,
                indicatorColor: Colors.white,
                onTap: controller.scrollToSection,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              )),
            ),
          )
        ],
        body: ListView.builder(
          itemCount: tabs.length,
          itemBuilder: (context, index) => _buildSection(index),
        ),
      ),
    );
  }

  Widget _buildSection(int index) {
    return Container(
      key: controller.sectionKeys[index],
      height: 800,
      color: Colors.primaries[index % Colors.primaries.length].shade200,
      child: Center(
        child: Text(
          "Content of ${tabs[index]}",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
