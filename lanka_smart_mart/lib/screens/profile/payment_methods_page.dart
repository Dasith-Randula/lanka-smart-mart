import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() =>
      _PaymentMethodsPageState();
}

class _PaymentMethodsPageState
    extends State<PaymentMethodsPage> {
  List<Map<String, String>> paymentMethods = [
    {
      'id': '1',
      'cardType': 'Visa',
      'lastDigits': '4242',
      'expiryDate': '12/25',
      'holderName': 'John Doe'
    },
    {
      'id': '2',
      'cardType': 'Mastercard',
      'lastDigits': '5555',
      'expiryDate': '08/26',
      'holderName': 'John Doe'
    },
  ];

  void _showAddCardDialog() {
    final cardNumberController =
        TextEditingController();
    final holderNameController =
        TextEditingController();
    final expiryController =
        TextEditingController();
    final cvvController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Card',
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
                controller: cardNumberController,
                maxLength: 16,
                keyboardType:
                    TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: holderNameController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  hintText: 'John Doe',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      maxLength: 5,
                      keyboardType:
                          TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Expiry',
                        hintText: 'MM/YY',
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      maxLength: 3,
                      keyboardType:
                          TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        hintText: '123',
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
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
              if (cardNumberController
                      .text.isNotEmpty &&
                  holderNameController
                      .text.isNotEmpty &&
                  expiryController
                      .text.isNotEmpty &&
                  cvvController.text.isNotEmpty) {
                String lastDigits =
                    cardNumberController.text
                        .substring(12);
                setState(() {
                  paymentMethods.add({
                    'id':
                        DateTime.now().toString(),
                    'cardType':
                        _getCardType(
                            cardNumberController
                                .text),
                    'lastDigits':
                        lastDigits,
                    'expiryDate':
                        expiryController.text,
                    'holderName':
                        holderNameController
                            .text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      'Card added successfully',
                      style: GoogleFonts.workSans(
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                    backgroundColor:
                        const Color(0xFF13EC5B),
                  ),
                );
              }
            },
            child: Text(
              'Add Card',
              style: GoogleFonts.workSans(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    cardNumberController.dispose();
    holderNameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
  }

  String _getCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (cardNumber.startsWith('5')) {
      return 'Mastercard';
    } else if (cardNumber.startsWith('3')) {
      return 'Amex';
    } else {
      return 'Card';
    }
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
          'Payment Methods',
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
              children: [
                ...paymentMethods.map((method) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(
                            bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                                12),
                        border: Border.all(
                          color:
                              Colors.grey[300]!,
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
                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                                16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 32,
                                      decoration:
                                          BoxDecoration(
                                        color: Colors
                                            .grey[200],
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                                    4),
                                      ),
                                      child:
                                          Center(
                                        child: Text(
                                          method['cardType']!
                                              .substring(
                                                  0,
                                                  1),
                                          style:
                                              GoogleFonts
                                                  .workSans(
                                            fontSize:
                                                14,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                            color: Colors
                                                .black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                      children: [
                                        Text(
                                          method['cardType']!,
                                          style:
                                              GoogleFonts
                                                  .workSans(
                                            fontSize:
                                                14,
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
                                          '•••• ${method['lastDigits']}',
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
                                  ],
                                ),
                                PopupMenuButton(
                                  onSelected:
                                      (value) {
                                    if (value ==
                                        'delete') {
                                      setState(
                                          () {
                                        paymentMethods
                                            .removeWhere(
                                          (m) =>
                                              m['id'] ==
                                              method[
                                                  'id'],
                                        );
                                      });
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(
                                            'Card removed',
                                            style: GoogleFonts
                                                .workSans(
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                          backgroundColor:
                                              Colors
                                                  .red,
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder:
                                      (context) => [
                                    const PopupMenuItem(
                                      value:
                                          'delete',
                                      child: Text(
                                          'Remove'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                                height: 12),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  'Expires: ${method['expiryDate']}',
                                  style:
                                      GoogleFonts
                                          .workSans(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight
                                            .w400,
                                    color: Colors
                                        .grey[600],
                                  ),
                                ),
                                Text(
                                  method['holderName']!,
                                  style:
                                      GoogleFonts
                                          .workSans(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight
                                            .w500,
                                    color: Colors
                                        .black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF13EC5B),
                    minimumSize: const Size(
                        double.infinity, 48),
                  ),
                  onPressed:
                      _showAddCardDialog,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add New Card',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
