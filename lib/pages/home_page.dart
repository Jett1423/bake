import 'package:bake/components/my_description_box.dart';
import 'package:bake/components/my_drawer.dart';
import 'package:bake/components/my_food_tile.dart';
import 'package:bake/components/my_sliver_app_bar.dart';
import 'package:bake/models/baker.dart';
import 'package:bake/models/food.dart';
import 'package:bake/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bake/pages/custom_cake.dart';

import '../components/my_tab_bar.dart';

class HomePage extends StatefulWidget {
  final bool useMaterial3;

  const HomePage({super.key, this.useMaterial3 = false});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out and return a list of cake items that is belong to the category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //return the list
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          //getting indiv food
          final food = categoryMenu[index];

          //return food tile
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Baker>(
          builder: (context, baker, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(baker.menu),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomCreatePage(),
            ),
          );
        },
        label: const Text(
          'Create own cake',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(
          Icons.cake,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
