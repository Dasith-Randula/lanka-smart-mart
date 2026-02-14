import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#ORD-001',
        'date': '14 Feb 2026',
        'amount': 'Rs. 1,250',
        'status': 'Delivered',
        'items': 'Fresh Vegetables, Fruits'
      },
      {
        'id': '#ORD-002',
        'date': '12 Feb 2026',
        'amount': 'Rs. 890',
        'status': 'Delivered',
        'items': 'Dairy Products, Eggs'
      },
      {
        'id': '#ORD-003',
        'date': '10 Feb 2026',
        'amount': 'Rs. 2,100',
        'status': 'Delivered',
        'items': 'Organic Groceries, Beverages'
      },
      {
        'id': '#ORD-004',
        'date': '08 Feb 2026',
        'amount': 'Rs. 560',
        'status': 'Returned',
        'items': 'Bakery Items'
      },
    ];

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
          'Order History',
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
              children: List.generate(
                orders.length,
                (index) {
                  final order = orders[index];
                  final isDelivered =
                      order['status'] == 'Delivered';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
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
                            color:
                                Colors.black.withOpacity(
                                    0.04),
                            blurRadius: 8,
                            offset:
                                const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  order['id']!,
                                  style: GoogleFonts
                                      .workSans(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Colors.black,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color: isDelivered
                                        ? const Color(
                                            0xFF13EC5B)
                                        : Colors.orange,
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                20),
                                  ),
                                  child: Text(
                                    order['status']!,
                                    style: GoogleFonts
                                        .workSans(
                                      fontSize: 11,
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date: ${order['date']}',
                              style: GoogleFonts
                                  .workSans(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Items: ${order['items']}',
                              style: GoogleFonts
                                  .workSans(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  order['amount']!,
                                  style: GoogleFonts
                                      .workSans(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Colors.black,
                                  ),
                                ),
                                if (isDelivered)
                                  ElevatedButton(
                                    style:
                                        ElevatedButton
                                            .styleFrom(
                                      backgroundColor:
                                          Colors.white,
                                      side:
                                          const BorderSide(
                                        color: Color(
                                            0xFF13EC5B),
                                      ),
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Tracking information for ${order['id']}',
                                            style: GoogleFonts
                                                .workSans(
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                          backgroundColor:
                                              const Color(
                                                  0xFF13EC5B),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Track',
                                      style: GoogleFonts
                                          .workSans(
                                        fontSize: 12,
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                        color: const Color(
                                            0xFF13EC5B),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
