import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/category_button_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'profile/profile_page.dart';
import 'fruits_screen.dart';
import '../models/product_model.dart';
import '../models/theme_provider.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  int _selectedCategory = 0;
  bool _isSearching = false;
  String _searchQuery = '';
  int _selectedBottomNav = 1;
  int? _previousCategory; // Track previous category for animation direction

  final List<String> categories = [
    'All Items',
    'Fruits',
    'Vegetables',
    'Diary',
    'Beverages',
    'Bakery',
  ];

  final List<ProductModel> allProducts = [
    // Fruits
    ProductModel(
      id: '1',
      name: 'Organic Mango',
      unitText: '1 Units',
      price: 120.0,
      description: 'Fresh organic mango from local farms.',
      imagePath: 'assets/images/mango.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '2',
      name: 'Fresh Avocado',
      unitText: '500g',
      price: 200.0,
      description: 'Crisp and fresh avocado.',
      imagePath: 'assets/images/Avocado.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '3',
      name: 'Banana',
      unitText: '1 kg',
      price: 150.0,
      description: 'Sweet and ripe bananas.',
      imagePath: 'assets/images/banana.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '4',
      name: 'Apple',
      unitText: '500g',
      price: 180.0,
      description: 'Crisp and juicy fresh apples.',
      imagePath: 'assets/images/apple.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '5',
      name: 'Kiwi',
      unitText: '500g',
      price: 220.0,
      description: 'Fresh and tangy kiwi fruits.',
      imagePath: 'assets/images/kiwi.jpg',
      category: 'Fruits',
    ),
    // More Fruits
    ProductModel(
      id: '6',
      name: 'Strawberry',
      unitText: '500g',
      price: 400.0,
      description: 'Sweet and fresh strawberries.',
      imagePath: 'assets/images/Strawberry.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '7',
      name: 'Grapes',
      unitText: '100g',
      price: 140.0,
      description: 'Seedless grapes, perfect for snacking.',
      imagePath: 'assets/images/grapes.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '8',
      name: 'Orange',
      unitText: '100g',
      price: 180.0,
      description: 'Juicy oranges full of vitamin C.',
      imagePath: 'assets/images/Orange.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '9',
      name: 'Pineapple',
      unitText: '1 Unit',
      price: 250.0,
      description: 'Sweet and tropical pineapple.',
      imagePath: 'assets/images/pineapple.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '10',
      name: 'Watermelon',
      unitText: '2 kg',
      price: 300.0,
      description: 'Juicy and refreshing watermelon.',
      imagePath: 'assets/images/watermelon.jpg',
      category: 'Fruits',
    ),
    // Vegetables
    ProductModel(
      id: '11',
      name: 'Carrot',
      unitText: '1 kg',
      price: 100.0,
      description: 'Fresh crunchy carrots.',
      imagePath: 'assets/images/carrot.jpg',
      category: 'Vegetables',
    ),
    ProductModel(
      id: '12',
      name: 'Spinach',
      unitText: '500g',
      price: 80.0,
      description: 'Nutritious green spinach leaves.',
      imagePath: 'assets/images/spinach.jpg',
      category: 'Vegetables',
    ),
    ProductModel(
      id: '13',
      name: 'Broccoli',
      unitText: '500g',
      price: 150.0,
      description: 'Fresh green broccoli florets.',
      imagePath: 'assets/images/brocoli.jpg',
      category: 'Vegetables',
    ),
    ProductModel(
      id: '14',
      name: 'Lettuce',
      unitText: '1 Unit',
      price: 70.0,
      description: 'Crisp lettuce leaves.',
      imagePath: 'assets/images/lettuce.jpg',
      category: 'Vegetables',
    ),
    ProductModel(
      id: '15',
      name: 'Cucumber',
      unitText: '500g',
      price: 90.0,
      description: 'Fresh cucumbers.',
      imagePath: 'assets/images/cucumber.jpg',
      category: 'Vegetables',
    ),
    // Dairy
    ProductModel(
      id: '16',
      name: 'Ice Cream',
      unitText: '1 L',
      price: 500.0,
      description: 'Creamy vanilla ice cream.',
      imagePath: 'assets/images/ice cream.jpg',
      category: 'Diary',
    ),
    ProductModel(
      id: '17',
      name: 'Milk',
      unitText: '1 L',
      price: 200.0,
      description: 'Fresh cow milk.',
      imagePath: 'assets/images/milk.jpg',
      category: 'Diary',
    ),
    ProductModel(
      id: '18',
      name: 'Yogurt',
      unitText: '500g',
      price: 150.0,
      description: 'Plain yogurt.',
      imagePath: 'assets/images/yogurt.jpg',
      category: 'Diary',
    ),
    ProductModel(
      id: '19',
      name: 'Eggs',
      unitText: '12 Units',
      price: 250.0,
      description: 'Fresh farm eggs.',
      imagePath: 'assets/images/egg.jpg',
      category: 'Diary',
    ),
    // Bakery
    ProductModel(
      id: '20',
      name: 'Bread',
      unitText: '1 Loaf',
      price: 120.0,
      description: 'Fresh baked bread.',
      imagePath: 'assets/images/Bread.jpg',
      category: 'Bakery',
    ),
    ProductModel(
      id: '21',
      name: 'Biscuits',
      unitText: '200g',
      price: 180.0,
      description: 'Assorted biscuits.',
      imagePath: 'assets/images/buiscuit.jpg',
      category: 'Bakery',
    ),
    // Rice
    ProductModel(
      id: '22',
      name: 'Rice',
      unitText: '1 kg',
      price: 300.0,
      description: 'Premium basmati rice.',
      imagePath: 'assets/images/rice.jpg',
      category: 'Bakery', // or separate, but user said add to bakery?
    ),
  ];

  List<ProductModel> get filteredProducts {
    List<ProductModel> filtered;

    // Filter by category
    if (_selectedCategory == 0) {
      // All Items shows all products
      filtered = allProducts;
    } else {
      filtered = allProducts
          .where((product) => product.category == categories[_selectedCategory])
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isEmpty) {
      return filtered;
    }
    return filtered
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.unitText.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF030303) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF111813) : Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
          child: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
        ),
        title: Text(
          'Groceries',
          style: GoogleFonts.workSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search field (shown when searching)
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchQuery = '';
                          _isSearching = false;
                        });
                      },
                      child: const Icon(Icons.close, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            // Category buttons
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CategoryButtonWidget(
                      label: categories[index],
                      isSelected: _selectedCategory == index,
                      onPressed: () {
                        if (categories[index] == 'Fruits') {
                          // Navigate to FruitsScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FruitsScreen(),
                            ),
                          );
                        } else {
                          setState(() {
                            _previousCategory = _selectedCategory;
                            _selectedCategory = index;
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            // Products grid with animation
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Text(
                        'No products found',
                        style: GoogleFonts.workSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        // Determine slide direction based on category change
                        final isMovingRight =
                            (_previousCategory ?? 0) > _selectedCategory;
                        final offset = isMovingRight
                            ? const Offset(1.0, 0)
                            : const Offset(-1.0, 0);

                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: offset,
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: GridView.builder(
                        key: ValueKey(_selectedCategory),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCardWidget(
                            product: product,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: _selectedBottomNav,
        onItemTapped: (index) {
          setState(() {
            _selectedBottomNav = index;
          });
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            // Category - already here
          } else if (index == 2) {
            // Cart
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          } else if (index == 3) {
            // Orders
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutPage()),
            );
          } else if (index == 4) {
            // Profile
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
