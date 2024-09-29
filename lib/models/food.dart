class Food {
  final String name;
  final String description;
  final String modelpath;
  final String imagepath;
  final double price;

  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagepath,
    required this.price,
    required this.category,
    required this.availableAddons,
    required this.modelpath,
  });
}

//cake categories

enum FoodCategory {
  anniversary,
  valentines,
  birthday,
  surprise,
  teacher,
}

//addons

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
