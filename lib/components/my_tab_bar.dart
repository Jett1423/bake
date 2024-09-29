import 'package:bake/models/food.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({
    super.key,
    required this.tabController,
  });

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: false, // Allows horizontal scrolling
      tabs: _buildCategoryTabs(),
      indicatorPadding:
          EdgeInsets.zero, // Adjust or remove indicator padding if necessary
      labelPadding: EdgeInsets.symmetric(
          horizontal: 5.0), // Adjust label padding as needed
    );
  }
}
