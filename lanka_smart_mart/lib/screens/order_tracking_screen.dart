import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'grocery_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'payment_screen.dart';
import 'order_tracking_map_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _selectedBottomNav = 3; // Orders tab
  int _currentStep = 1; // 0: Order Placed, 1: Order Packed, 2: Out for Delivery, 3: Delivered

  final List<String> steps = [
    'Order Placed',
    'Order Packed',
    'Out for Delivery',
    'Delivered',
  ];

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
            MaterialPageRoute(builder: (context) => const PaymentScreen()),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Order Tracking',
          style: GoogleFonts.workSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Confirmation Section
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFA3E6B9),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF13EC5B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Thank You for Your Order!',
                        style: GoogleFonts.workSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Order ID: #123456789',
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Order Progress Tracking
                _buildOrderProgress(),
                const SizedBox(height: 32),

                // Tracking Card Section
                _buildTrackingCard(),
                const SizedBox(height: 24),

                // Back to Home Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13EC5B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.workSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
            // Category
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GroceriesPage()),
            );
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
          }
        },
      ),
    );
  }

  Widget _buildOrderProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Progress',
          style: GoogleFonts.workSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          itemBuilder: (context, index) {
            bool isCompleted = index <= _currentStep;
            bool isLast = index == steps.length - 1;
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16, left: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isCompleted ? const Color(0xFF13EC5B) : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle,
                          color: isCompleted ? Colors.white : Colors.grey[500],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              steps[index],
                              style: GoogleFonts.workSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isCompleted ? Colors.black : Colors.grey[500],
                              ),
                            ),
                            if (isCompleted)
                              Text(
                                'Completed',
                                style: GoogleFonts.workSans(
                                  fontSize: 12,
                                  color: const Color(0xFF13EC5B),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Positioned(
                    left: 48,
                    top: 48,
                    child: Container(
                      width: 2,
                      height: 32,
                      color: isCompleted ? const Color(0xFF13EC5B) : Colors.grey[300],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrackingCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image (placeholder for delivery truck)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200], // Placeholder color
            ),
            child: const Center(
              child: Icon(
                Icons.local_shipping,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),
          // Location pin
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
          // Track Now Button
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderTrackingMapScreen(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Track Now',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
