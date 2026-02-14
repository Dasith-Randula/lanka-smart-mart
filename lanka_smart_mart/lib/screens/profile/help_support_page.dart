import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() =>
      _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I track my order?',
      'answer':
          'You can track your order from the "Orders" section in your profile. Click on any order to see real-time tracking information with delivery estimates.',
    },
    {
      'question': 'What are your delivery hours?',
      'answer':
          'We offer delivery from 7:00 AM to 10:00 PM daily. Special orders can be scheduled in advance.',
    },
    {
      'question': 'Can I cancel my order?',
      'answer':
          'Orders can be cancelled within 30 minutes of placement. After that, please contact our support team.',
    },
    {
      'question': 'Is there a minimum order value?',
      'answer':
          'Yes, the minimum order value is Rs. 500 for free delivery. Orders below this may incur a delivery fee.',
    },
    {
      'question': 'How do I return an item?',
      'answer':
          'If an item is damaged or not as described, contact support within 48 hours of delivery with photos. We will arrange a pickup.',
    },
    {
      'question': 'What payment methods do you accept?',
      'answer':
          'We accept all major credit/debit cards, digital wallets, and cash on delivery options.',
    },
  ];

  final List<bool> expandedStates = [];

  @override
  void initState() {
    super.initState();
    expandedStates.addAll(List.filled(faqs.length, false));
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
          child: const Icon(Icons.arrow_back,
              color: Colors.black),
        ),
        title: Text(
          'Help & Support',
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
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF13EC5B)
                        .withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF13EC5B),
                      width: 1,
                    ),
                  ),
                  padding:
                      const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: GoogleFonts.workSans(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Got a question or issue? Browse our FAQs below or contact our support team.',
                        style: GoogleFonts.workSans(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w400,
                          color: Colors
                              .black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  faqs.length,
                  (index) {
                    final faq = faqs[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                              bottom: 8),
                      child: Container(
                        decoration:
                            BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(12),
                          border: Border.all(
                            color: Colors
                                .grey[300]!,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(
                                      0.04),
                              blurRadius: 8,
                              offset:
                                  const Offset(
                                      0,
                                      2),
                            ),
                          ],
                        ),
                        child: ExpansionTile(
                          title: Text(
                            faq['question']!,
                            style: GoogleFonts
                                .workSans(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight
                                      .w600,
                              color:
                                  Colors
                                      .black,
                            ),
                          ),
                          trailing: Icon(
                            expandedStates[
                                    index]
                                ? Icons
                                    .expand_less
                                : Icons
                                    .expand_more,
                            color: const Color(
                                0xFF13EC5B),
                          ),
                          onExpansionChanged:
                              (expanded) {
                            setState(() {
                              expandedStates[
                                      index] =
                                  expanded;
                            });
                          },
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Text(
                                faq['answer']!,
                                style: GoogleFonts
                                    .workSans(
                                  fontSize:
                                      13,
                                  fontWeight:
                                      FontWeight
                                          .w400,
                                  color: Colors
                                      .grey[700],
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Contact Support',
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
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger
                                .of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Email: support@lankamartdelivery.com',
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
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .mail_outline,
                                  size: 24,
                                  color: Colors
                                      .grey[700],
                                ),
                                const SizedBox(
                                    width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        'Email',
                                        style:
                                            GoogleFonts
                                                .workSans(
                                          fontSize:
                                              15,
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                          color: Colors
                                              .black,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              4),
                                      Text(
                                        'support@lankamartdelivery.com',
                                        style:
                                            GoogleFonts
                                                .workSans(
                                          fontSize:
                                              12,
                                          fontWeight:
                                              FontWeight
                                                  .w400,
                                          color: Colors
                                              .grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons
                                      .arrow_forward_ios,
                                  size: 16,
                                  color: Colors
                                      .grey[400],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 56,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger
                                .of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Phone: +94 11 234 5678',
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
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .phone_outlined,
                                  size: 24,
                                  color: Colors
                                      .grey[700],
                                ),
                                const SizedBox(
                                    width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        'Phone',
                                        style:
                                            GoogleFonts
                                                .workSans(
                                          fontSize:
                                              15,
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                          color: Colors
                                              .black,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              4),
                                      Text(
                                        '+94 11 234 5678',
                                        style:
                                            GoogleFonts
                                                .workSans(
                                          fontSize:
                                              12,
                                          fontWeight:
                                              FontWeight
                                                  .w400,
                                          color: Colors
                                              .grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons
                                      .arrow_forward_ios,
                                  size: 16,
                                  color: Colors
                                      .grey[400],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 56,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _showSupportForm();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .message_outlined,
                                  size: 24,
                                  color: Colors
                                      .grey[700],
                                ),
                                const SizedBox(
                                    width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        'Live Chat',
                                        style:
                                            GoogleFonts
                                                .workSans(
                                          fontSize:
                                              15,
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                          color: Colors
                                              .black,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              4),
                                      Text(
                                        'Chat with our support team',
                                        style:
                                            GoogleFonts
                                                .workSans(
                                          fontSize:
                                              12,
                                          fontWeight:
                                              FontWeight
                                                  .w400,
                                          color: Colors
                                              .grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons
                                      .arrow_forward_ios,
                                  size: 16,
                                  color: Colors
                                      .grey[400],
                                ),
                              ],
                            ),
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

  void _showSupportForm() {
    final messageController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Send Message',
          style: GoogleFonts.workSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: 5,
                controller: messageController,
                decoration: InputDecoration(
                  hintText:
                      'Describe your issue or question...',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.workSans(
                  color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF13EC5B),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(
                    'Your message has been sent. We will get back to you shortly.',
                    style: GoogleFonts.workSans(
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                  backgroundColor:
                      const Color(0xFF13EC5B),
                ),
              );
            },
            child: Text(
              'Send',
              style: GoogleFonts.workSans(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    messageController.dispose();
  }
}
