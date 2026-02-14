import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/category_button_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'grocery_screen.dart';
import 'home_screen.dart';
import 'strawberry_detail_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'profile/profile_page.dart';
import '../models/product_model.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({super.key});

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  int _selectedCategory = 1; // Fruits selected by default
  bool _isSearching = false;
  String _searchQuery = '';
  int _selectedBottomNav = 1;

  final List<String> categories = [
    'All Items',
    'Fruits',
    'Vegetables',
    'Diary',
    'Beverages',
    'Bakery',
  ];

  final List<ProductModel> fruitProducts = [
    ProductModel(
      id: '1',
      name: 'Organic Mango',
      unitText: '1 Units',
      price: 120,
      imagePath: '',
    ),
    ProductModel(
      id: '2',
      name: 'Strawberry',
      unitText: '500g',
      price: 400,
      imagePath: '',
      isOrganic: true,
      highFiber: true,
      description:
          'Fresh Strawberry 🍓\nSweet, juicy, and hand picked for quality. These fresh strawberries are packed with natural flavor and nutrients perfect for snacking, desserts, smoothies or breakfast bowls. Enjoy farm fresh goodness delivered straight to your doorstep.',
    ),
    ProductModel(
      id: '3',
      name: 'Grapes',
      unitText: '100g',
      price: 140,
      imagePath: '',
    ),
    ProductModel(
      id: '4',
      name: 'Orange',
      unitText: '100g',
      price: 180,
      imagePath: '',
    ),
    ProductModel(
      id: '5',
      name: 'Fresh Bananas',
      unitText: '1 Bunch',
      price: 80,
      imagePath: '',
    ),
    ProductModel(
      id: '6',
      name: 'Watermelon',
      unitText: '1 kg',
      price: 250,
      imagePath: '',
    ),
    ProductModel(
      id: '7',
      name: 'Fresh Apples',
      unitText: '1 kg',
      price: 320,
      imagePath: '',
    ),
    ProductModel(
      id: '8',
      name: 'Papaya',
      unitText: '1 kg',
      price: 150,
      imagePath: '',
    ),
  ];

  List<ProductModel> get filteredProducts {
    if (_searchQuery.isEmpty) {
      return fruitProducts;
    }
    return fruitProducts
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.unitText
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GroceryScreen(),
            ),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Fruits',
          style: GoogleFonts.workSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
                    hintText: 'Search fruits...',
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
                        // NAVIGATION LOGIC FOR ALL ITEMS
                        if (index == 0) {
                          // All Items -> navigate back to Grocery
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GroceryScreen(),
                            ),
                          );
                        } else {
                          setState(() {
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
                        'No fruits found',
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
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0),
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
                          return GestureDetector(
                            onTap: () {
                              // ONLY Strawberry opens detail page
                              if (product.name == 'Strawberry') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StrawberryDetailScreen(
                                      product: product,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: ProductCardWidget(
                              product: product,
                            ),
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
            // Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else if (index == 1) {
            // Category
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GroceryScreen(),
              ),
            );
          } else if (index == 2) {
            // Cart
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          } else if (index == 3) {
            // Orders
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CheckoutScreen(),
              ),
            );
          } else if (index == 4) {
            // Profile
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
