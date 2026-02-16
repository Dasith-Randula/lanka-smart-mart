import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import 'cart_screen.dart';

class StrawberryDetailsPage extends StatefulWidget {
  final ProductModel product;

  const StrawberryDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<StrawberryDetailsPage> createState() => _StrawberryDetailsPageState();
}

class _StrawberryDetailsPageState extends State<StrawberryDetailsPage> {
  int _quantity = 0;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    if (_quantity == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select at least 1 item',
            style: GoogleFonts.workSans(fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<CartModel>().addItem(widget.product, _quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.name} added to cart',
          style: GoogleFonts.workSans(fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF13EC5B),
      ),
    );

    // Navigate to cart
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Product Details',
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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.product.imagePath!,
                      width: 280,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Product Name
                Text(
                  widget.product.name,
                  style: GoogleFonts.workSans(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF314035),
                  ),
                ),
                const SizedBox(height: 8),

                // Unit Text
                Text(
                  widget.product.unitText,
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),

                // Badges
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildBadge(
                        label: 'Organic',
                        backgroundColor: const Color(0xFFC8E6C9),
                        textColor: const Color(0xFF2E7D32),
                        hasIcon: true,
                      ),
                      const SizedBox(width: 12),
                      _buildBadge(
                        label: 'In Stock',
                        backgroundColor: const Color(0xFFAAC4F8),
                        textColor: const Color(0xFF325FBE),
                      ),
                      const SizedBox(width: 12),
                      _buildBadge(
                        label: 'High Fiber',
                        backgroundColor: const Color(0xFFF7BE9D),
                        textColor: const Color(0xFFED7433),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Price Section
                Text(
                  'Price',
                  style: GoogleFonts.workSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rs.${widget.product.price}',
                  style: GoogleFonts.workSans(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF13EC5B),
                  ),
                ),
                const SizedBox(height: 32),

                // Quantity Selector
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _decrementQuantity,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: _quantity == 0 ? Colors.grey[300] : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 18,
                            color: _quantity == 0 ? Colors.grey[400] : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$_quantity',
                        style: GoogleFonts.workSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: _incrementQuantity,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Description
                Text(
                  widget.product.description.isNotEmpty
                      ? widget.product.description
                      : 'Fresh Strawberry 🍓\nSweet, juicy and hand picked for quality.',
                  style: GoogleFonts.workSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),

                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13EC5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Add to Cart',
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    bool hasIcon = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIcon) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: GoogleFonts.workSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
