import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'grocery_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'profile/profile_page.dart';
import '../models/product_model.dart';
import '../models/theme_provider.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/bottom_navigation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBranch = 0;
  int _currentPromoIndex = 0;
  int _selectedBottomNav = 0;

  final List<String> branches = ['Maharagama', 'Gampaha', 'Kandy'];
  final List<Map<String, String>> categories = [
    {'name': 'Groceries', 'icon': 'assets/images/food.png'},
    {'name': 'Household', 'icon': 'assets/images/house.png'},
    {'name': 'Personal Care', 'icon': 'assets/images/flower.png'},
    {'name': 'Stationery', 'icon': 'assets/images/stationery.png'},
    {'name': 'Electronics', 'icon': 'assets/images/thunder.png'},
  ];

  // Special offers products
  final List<ProductModel> specialOffers = [
    ProductModel(
      id: '101',
      name: 'Organic Avocado',
      category: 'Fruits',
      unitText: '500g',
      price: 320.0,
      description: 'Crisp and juicy fresh avocado.',
      imagePath: 'assets/images/Avocado.jpg',
    ),
    ProductModel(
      id: '102',
      name: 'Whole Bread',
      category: 'Bakery',
      unitText: '400 g',
      price: 240.0,
      description: 'Fresh whole wheat bread.',
      imagePath: 'assets/images/Bread.jpg',
    ),
    ProductModel(
      id: '104',
      name: 'Orange',
      unitText: '100 g',
      price: 250.0,
      description: 'Crisp and juicy fresh oranges.',
      imagePath: 'assets/images/Orange.jpg',
      category: 'Fruits',
    ),
    ProductModel(
      id: '105',
      name: 'Coconut',
      category: 'All Items',
      unitText: '800g',
      price: 100.0,
      description: 'Coconut.',
      imagePath: 'assets/images/Coconut.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [const Color(0xFF094820), const Color(0xFF030303)]
                : [const Color(0xFFD2E6DA), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Positioned(child:Container(
                              margin: const EdgeInsets.only(left: 42),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/logo_green.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                            const SizedBox(width: 12),
                            Text(
                              'LankaSmartMart',
                              style: GoogleFonts.workSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _showNotificationsPanel,
                              child: const Icon(Icons.notifications_none, size: 24, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GestureDetector(
                          onTap: () {
                            _showBranchDropdown(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SELECT BRANCH',
                                      style: GoogleFonts.workSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      branches[_selectedBranch],
                                      style: GoogleFonts.workSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.expand_more, size: 20, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for milk,bread,etc.',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefixIcon: const Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            style: GoogleFonts.workSans(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: PageView(
                          onPageChanged: (index) {
                            setState(() {
                              _currentPromoIndex = index;
                            });
                          },
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/Promo_${index + 1}.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 20,
                                      right: 140,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF13EC5B),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          'Shop Now',
                                          style: GoogleFonts.workSans(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPromoIndex == index
                                  ? const Color(0xFF13EC5B)
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: GoogleFonts.workSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'See All',
                              style: GoogleFonts.workSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF13EC5B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final isGroceries = categories[index]['name'] == 'Groceries';
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: isGroceries
                                    ? () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const GroceriesPage(),
                                          ),
                                        )
                                    : null,
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 6,
                                        color: Colors.black.withOpacity(0.08),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        categories[index]['icon']!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.contain
                                        ),

                                      const SizedBox(height: 8),
                                      Text(
                                        categories[index]['name']!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.workSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFC9F5D7),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10A958),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'LIMITED OFFER',
                                        style: GoogleFonts.workSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Fresh Veggies\nup to 30% Off',
                                      style: GoogleFonts.workSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF0FBA48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Shop Now',
                                        style: GoogleFonts.workSans(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/Vegitables.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Special Offers',
                              style: GoogleFonts.workSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'See All',
                              style: GoogleFonts.workSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF13EC5B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: specialOffers.length,
                          itemBuilder: (context, index) {
                            final product = specialOffers[index];
                            return Stack(
                              children: [
                                ProductCardWidget(
                                  product: product,
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '20% off',
                                      style: GoogleFonts.workSans(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: BottomNavigationWidget(
                  selectedIndex: _selectedBottomNav,
                  onItemTapped: (index) {
                    setState(() {
                      _selectedBottomNav = index;
                    });
                    // Navigation logic
                    if (index == 0) {
                      // Home - already here
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBranchDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                branches.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBranch = index;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    color: _selectedBranch == index
                        ? const Color(0xFF13EC5B).withOpacity(0.1)
                        : Colors.transparent,
                    child: Text(
                      branches[index],
                      style: GoogleFonts.workSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _selectedBranch == index
                            ? const Color(0xFF13EC5B)
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNotificationsPanel() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: GoogleFonts.workSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 24),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], height: 1),
                // Notifications List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNotificationItem(
                          icon: Icons.check_circle,
                          iconColor: const Color(0xFF13EC5B),
                          title: 'Order Confirmed',
                          subtitle: 'Your order #123456 has been confirmed',
                          time: '2 min ago',
                        ),
                        Divider(color: Colors.grey[200], height: 1),
                        _buildNotificationItem(
                          icon: Icons.local_shipping,
                          iconColor: Colors.blue,
                          title: 'Order Shipped',
                          subtitle: 'Your order is on the way to you',
                          time: '25 min ago',
                        ),
                        Divider(color: Colors.grey[200], height: 1),
                        _buildNotificationItem(
                          icon: Icons.schedule,
                          iconColor: Colors.orange,
                          title: 'Delivery Arriving Soon',
                          subtitle: 'Estimated delivery in 30 minutes',
                          time: '1 hour ago',
                        ),
                        Divider(color: Colors.grey[200], height: 1),
                        _buildNotificationItem(
                          icon: Icons.local_offer,
                          iconColor: Colors.red,
                          title: 'Special Discount Available',
                          subtitle: 'Get 20% off on groceries this week',
                          time: '2 hours ago',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: GoogleFonts.workSans(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
