import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/category_button_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'grocery_screen.dart';
import 'home_screen.dart';

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

  final List<Map<String, String>> fruitProducts = [
    {
      'title': 'Organic Mango',
      'quantity': '1 Units',
      'price': 'Rs.120',
    },
    {
      'title': 'Strawberry',
      'quantity': '500g',
      'price': 'Rs.400',
    },
    {
      'title': 'Grapes',
      'quantity': '100g',
      'price': 'Rs.140',
    },
    {
      'title': 'Orange',
      'quantity': '100g',
      'price': 'Rs.180',
    },
    {
      'title': 'Fresh Bananas',
      'quantity': '1 Bunch',
      'price': 'Rs.80',
    },
    {
      'title': 'Watermelon',
      'quantity': '1 kg',
      'price': 'Rs.250',
    },
    {
      'title': 'Fresh Apples',
      'quantity': '1 kg',
      'price': 'Rs.320',
    },
    {
      'title': 'Papaya',
      'quantity': '1 kg',
      'price': 'Rs.150',
    },
  ];

  List<Map<String, String>> get filteredProducts {
    if (_searchQuery.isEmpty) {
      return fruitProducts;
    }
    return fruitProducts
        .where((product) =>
            product['title']!
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            product['quantity']!
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
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            // Products grid
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
                  : GridView.builder(
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
                          imageUrl: '',
                          title: product['title']!,
                          quantity: product['quantity']!,
                          price: product['price']!,
                          onAddPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product['title']} added to cart',
                                ),
                              ),
                            );
                          },
                        );
                      },
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cart screen coming soon')),
            );
          } else if (index == 3) {
            // Orders
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Orders screen coming soon')),
            );
          } else if (index == 4) {
            // Profile
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile screen coming soon')),
            );
          }
        },
      ),
    );
  }
}
