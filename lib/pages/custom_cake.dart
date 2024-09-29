import 'package:bake/components/my_buttons.dart';
import 'package:bake/pages/cart_page.dart';
import 'package:bake/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:bake/models/baker.dart'; // Import Baker
import 'package:bake/models/food.dart'; // Import Food

class CustomCreatePage extends StatefulWidget {
  const CustomCreatePage({super.key});

  @override
  State<CustomCreatePage> createState() => _CustomCreatePage();
}

class _CustomCreatePage extends State<CustomCreatePage> {
  // Initial selections
  String _selectedLayer = '1 tier Cake';
  String _selectedFlavor = 'Empty';
  String _selectedTopping = 'None';
  String _selectedDrip = 'Empty';
  String _modelPath = 'assets/3d/round.glb';
  double _price = 0.0;

  // A map to store model paths based on layer, flavor, and topping combinations
  final Map<String, String> toppingModels = {
    '1 tier Cake-Blueberry-Cone': 'assets/3d/Blue_cake_cone.glb',
    '1 tier Cake-Strawberry-Cone': 'assets/3d/red_cake_cone.glb',
    '1 tier Cake-Blueberry-Cube': 'assets/3d/Blue_cake_cube.glb',
    '1 tier Cake-Strawberry-Cube': 'assets/3d/red_cake_cube.glb',
    '2 tier Cake-Blueberry-Cone': 'assets/3d/Blue_2Lcake_cone.glb',
    '2 tier Cake-Strawberry-Cone': 'assets/3d/Red_2Lcake_cone.glb',
    '2 tier Cake-Blueberry-Cube': 'assets/3d/Blue_2Lcake_Cube.glb',
    '2 tier Cake-Strawberry-Cube': 'assets/3d/Red_2Lcake_Cube.glb',
  };

  // Price map for each component
  final Map<String, double> _tierPrices = {
    '1 tier Cake': 10.0,
    '2 tier Cake': 15.0,
    '3 tier Cake': 20.0,
  };

  final Map<String, double> _flavorPrices = {
    'Empty': 0.0,
    'Blueberry': 5.0,
    'Strawberry': 5.0,
  };

  final Map<String, double> _toppingPrices = {
    'None': 0.0,
    'Cone': 2.0,
    'Cube': 3.0,
  };

  final Map<String, double> _dripPrices = {
    'Empty': 0.0,
    'Drip Caramel': 3.0,
    'Chocolate': 3.0,
  };

  // Function to calculate the price based on selected components
  void _updatePrice() {
    setState(() {
      _price = _tierPrices[_selectedLayer]! +
          _flavorPrices[_selectedFlavor]! +
          _toppingPrices[_selectedTopping]! +
          _dripPrices[_selectedDrip]!;
    });
  }

  void _updateModelPath() {
    setState(() {
      String baseModel = _getModelPath();
      baseModel = _getToppingModel(baseModel); // Apply topping selection
      _modelPath = _getDripModel(baseModel); // Apply drip selection
      _updatePrice(); // Update price calculation
    });
  }

  // Get the base model path based on layer and flavor
  String _getModelPath() {
    switch (_selectedLayer) {
      case '1 tier Cake':
        return _get1TierModel();
      case '2 tier Cake':
        return _get2TierModel();
      case '3 tier Cake':
        return _get3TierModel();
      default:
        return 'assets/3d/round.glb';
    }
  }

  String _get1TierModel() {
    switch (_selectedFlavor) {
      case 'Empty':
        return 'assets/3d/round.glb';
      case 'Blueberry':
        return 'assets/3d/Blue_cake.glb';
      case 'Strawberry':
        return 'assets/3d/red_cake.glb';
      default:
        return 'assets/3d/round.glb';
    }
  }

  String _get2TierModel() {
    switch (_selectedFlavor) {
      case 'Empty':
        return 'assets/3d/2nd_layer.glb';
      case 'Blueberry':
        return 'assets/3d/Blue_2Lcake.glb';
      case 'Strawberry':
        return 'assets/3d/Red_2Lcake.glb';
      default:
        return 'assets/3d/2nd_layer.glb';
    }
  }

  String _get3TierModel() {
    switch (_selectedFlavor) {
      case 'Empty':
        return 'assets/3d/round.glb';
      case 'Blueberry':
        return 'assets/3d/Blue_cake.glb';
      case 'Strawberry':
        return 'assets/3d/red_cake.glb';
      default:
        return 'assets/3d/round.glb';
    }
  }

  // Apply topping selection and get the correct model
  String _getToppingModel(String baseModel) {
    if (_selectedTopping == 'None') {
      return baseModel;
    }
    String key = '$_selectedLayer-$_selectedFlavor-$_selectedTopping';
    return toppingModels.containsKey(key) ? toppingModels[key]! : baseModel;
  }

  // Apply drip selection
  String _getDripModel(String baseModel) {
    switch (_selectedDrip) {
      case 'Empty':
        return baseModel;
      case 'Drip Caramel':
        return 'assets/3d/${baseModel}_caramel.glb';
      case 'Chocolate':
        return 'assets/3d/${baseModel}_chocolate.glb';
      default:
        return baseModel;
    }
  }

  // Add to cart
  void _addToCart(BuildContext context) {
    // Create a CartItem
    final food = Food(
      name:
          "Customized Cake $_selectedLayer, $_selectedFlavor, $_selectedTopping, and $_selectedDrip",
      description:
          "A cake with $_selectedLayer, $_selectedFlavor, $_selectedTopping, and $_selectedDrip",
      imagepath:
          "assets/images/grab.png", // Use 3D model as the image path here
      modelpath: _modelPath,
      price: _price,
      category: FoodCategory.anniversary, // Or some custom category
      availableAddons: [],
    );

    // Add to cart using the Baker provider
    Provider.of<Baker>(context, listen: false).addToCart(food, []);

    // Navigate to cart page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        title: const Text('Create your own cake'),
      ),
      body: Column(
        children: [
          // Dropdowns in a row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildDropdownButton(
                    title: 'Tier',
                    value: _selectedLayer,
                    items: ['1 tier Cake', '2 tier Cake', '3 tier Cake'],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLayer = newValue!;
                        _selectedFlavor = 'Empty'; // Reset other selections
                        _selectedTopping = 'None';
                        _selectedDrip = 'Empty';
                        _updateModelPath();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _buildDropdownButton(
                    title: 'Flavor',
                    value: _selectedFlavor,
                    items: ['Empty', 'Blueberry', 'Strawberry'],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFlavor = newValue!;
                        _selectedTopping = 'None'; // Reset selections
                        _selectedDrip = 'Empty';
                        _updateModelPath();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _buildDropdownButton(
                    title: 'Topping',
                    value: _selectedTopping,
                    items: ['None', 'Cone', 'Cube'],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTopping = newValue!;
                        _selectedDrip = 'Empty'; // Reset drip
                        _updateModelPath();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: _buildDropdownButton(
                    title: 'Drip',
                    value: _selectedDrip,
                    items: ['Empty', 'Drip Caramel', 'Chocolate'],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDrip = newValue!;
                        _updateModelPath();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Display the 3D model
          Expanded(
            child: ModelViewer(
              key: ValueKey(_modelPath),
              backgroundColor: const Color(0xFFEEEEEE),
              src: _modelPath,
              alt: 'A 3D model of a cake',
              ar: true,
              autoPlay: true,
              autoRotate: false,
              disableZoom: true,
              cameraControls: true,
            ),
          ),

          // Display price
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Price: ₱${_price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Add to cart button
          MyButtons(
            text: "Add to cart",
            onTap: () => _addToCart(context),
          ),
        ],
      ),
    );
  }

  // Helper method to build dropdown buttons
  Widget _buildDropdownButton({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
