import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: const Color(0xFF13EC5B),
        unselectedItemColor: Colors.grey,
        items: [
          _buildNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isSelected: selectedIndex == 0,
          ),
          _buildNavItem(
            icon: Icons.category_outlined,
            label: 'Category',
            isSelected: selectedIndex == 1,
          ),
          _buildNavItem(
            icon: Icons.shopping_cart_outlined,
            label: 'Cart',
            isSelected: selectedIndex == 2,
          ),
          _buildNavItem(
            icon: Icons.receipt_outlined,
            label: 'Orders',
            isSelected: selectedIndex == 3,
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isSelected: selectedIndex == 4,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(
          icon,
          size: 24,
          color: isSelected ? const Color(0xFF13EC5B) : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
