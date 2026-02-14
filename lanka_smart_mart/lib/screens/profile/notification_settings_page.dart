import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsPage
    extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState
    extends State<NotificationSettingsPage> {
  bool _orderUpdates = true;
  bool _promotions = false;
  bool _newArrivals = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back,
              color: Colors.black),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.workSans(
            fontSize: 20,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification Types',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.04),
                        blurRadius: 8,
                        offset:
                            const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildNotificationTile(
                        icon:
                            Icons.shopping_bag_outlined,
                        title: 'Order Updates',
                        subtitle:
                            'Receive updates about your orders',
                        value: _orderUpdates,
                        onChanged: (value) {
                          setState(() =>
                              _orderUpdates =
                                  value);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 56,
                      ),
                      _buildNotificationTile(
                        icon: Icons.local_offer_outlined,
                        title: 'Promotions',
                        subtitle:
                            'Get special offers and discounts',
                        value: _promotions,
                        onChanged: (value) {
                          setState(() =>
                              _promotions =
                                  value);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 56,
                      ),
                      _buildNotificationTile(
                        icon: Icons.stars_outlined,
                        title: 'New Arrivals',
                        subtitle:
                            'Be notified of new products',
                        value: _newArrivals,
                        onChanged: (value) {
                          setState(() =>
                              _newArrivals =
                                  value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Notification Channels',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.04),
                        blurRadius: 8,
                        offset:
                            const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildNotificationTile(
                        icon: Icons.notifications,
                        title: 'Push Notifications',
                        subtitle:
                            'App notifications on your device',
                        value:
                            _pushNotifications,
                        onChanged: (value) {
                          setState(() =>
                              _pushNotifications =
                                  value);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 56,
                      ),
                      _buildNotificationTile(
                        icon: Icons.mail_outline,
                        title: 'Email',
                        subtitle:
                            'Notifications via email',
                        value:
                            _emailNotifications,
                        onChanged: (value) {
                          setState(() =>
                              _emailNotifications =
                                  value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue[200]!,
                      width: 1,
                    ),
                  ),
                  padding:
                      const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You can change these settings anytime. At least one notification channel must remain enabled.',
                          style: GoogleFonts.workSans(
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w400,
                            color: Colors
                                .blue[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.workSans(
                    fontSize: 15,
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
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor:
                const Color(0xFF13EC5B),
          ),
        ],
      ),
    );
  }
}
