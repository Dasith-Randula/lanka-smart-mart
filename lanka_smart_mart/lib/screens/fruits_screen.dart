import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
import '../models/theme_provider.dart';

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

  final List<ProductModel> fruitsProducts = [
    ProductModel(
      id: '1',
      name: 'Organic Mango',
      unitText: '1 Unit',
      price: 120.0,
      description: 'Fresh organic mango picked from local farms.',
      imagePath: '',
      category: 'Fruits',
    ),
    ProductModel(
      id: '7',
      name: 'Strawberry',
      unitText: '500g',
      price: 400.0,
      description: 'Sweet and fresh strawberries.',
      imagePath: '',
      category: 'Fruits',
    ),
    ProductModel(
      id: '8',
      name: 'Grapes',
      unitText: '100g',
      price: 140.0,
      description: 'Seedless grapes, perfect for snacking.',
      imagePath: '',
      category: 'Fruits',
    ),
    ProductModel(
      id: '9',
      name: 'Orange',
      unitText: '100g',
      price: 180.0,
      description: 'Juicy oranges full of vitamin C.',
      imagePath: '',
      category: 'Fruits',
    ),
  ];

  List<ProductModel> get filteredProducts {
    if (_searchQuery.isEmpty) {
      return fruitsProducts;
    }
    return fruitsProducts
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.unitText
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
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
              builder: (context) => const GroceriesPage(),
            ),
          ),
          child: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
        ),
        title: Text(
          'Fruits',
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
                              builder: (context) => const GroceriesPage(),
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
                          return product.name == 'Strawberry'
                              ? InkWell(
                                  onTap: () {
                                    print("Strawberry clicked");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StrawberryDetailsPage(
                                          product: product,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ProductCardWidget(
                                    product: product,
                                  ),
                                )
                              : ProductCardWidget(
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
            // Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (index == 1) {
            // Category
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GroceriesPage(),
              ),
            );
          } else if (index == 2) {
            // Cart
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          } else if (index == 3) {
            // Orders
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CheckoutPage(),
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
