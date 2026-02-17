import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddressManagementPage extends StatefulWidget {
  const AddressManagementPage({super.key});

  @override
  State<AddressManagementPage> createState() =>
      _AddressManagementPageState();
}

class _AddressManagementPageState extends State<AddressManagementPage> {
  List<Map<String, String>> addresses = [
    {
      'id': '1',
      'label': 'Home',
      'address': '123 Main Street, Colombo 3, Sri Lanka',
      'instructions': 'Ring the door bell twice'
    },
    {
      'id': '2',
      'label': 'Work',
      'address': '456 Business Park, Colombo 5, Sri Lanka',
      'instructions': 'Ask for reception desk'
    },
  ];

  void _showAddAddressDialog() {
    final labelController = TextEditingController();
    final addressController = TextEditingController();
    final instructionsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Address',
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
                controller: labelController,
                decoration: InputDecoration(
                  hintText: 'Address Label (e.g., Home, Work)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Full Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: instructionsController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Delivery Instructions (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13EC5B),
                  minimumSize: const Size(double.infinity, 44),
                ),
                onPressed: () => _selectAddressFromMap(
                  addressController,
                  context,
                ),
                icon: const Icon(Icons.location_on, color: Colors.white),
                label: Text(
                  'Select from Map',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.workSans(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF13EC5B),
            ),
            onPressed: () {
              if (labelController.text.isNotEmpty &&
                  addressController.text.isNotEmpty) {
                setState(() {
                  addresses.add({
                    'id': DateTime.now().toString(),
                    'label': labelController.text,
                    'address': addressController.text,
                    'instructions':
                        instructionsController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Address added successfully',
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500),
                    ),
                    backgroundColor:
                        const Color(0xFF13EC5B),
                  ),
                );
              }
            },
            child: Text(
              'Add',
              style: GoogleFonts.workSans(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    labelController.dispose();
    addressController.dispose();
    instructionsController.dispose();
  }

  void _selectAddressFromMap(
    TextEditingController addressController,
    BuildContext dialogContext,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectAddressMapScreen(),
      ),
    );

    if (result != null && result is String) {
      addressController.text = result;
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
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Manage Addresses',
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
                ...addresses.map((address) {
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
                                  address['label']!,
                                  style: GoogleFonts
                                      .workSans(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Colors.black,
                                  ),
                                ),
                                PopupMenuButton(
                                  onSelected: (value) {
                                    if (value ==
                                        'edit') {
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(
                                            'Edit functionality for ${address['label']}',
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
                                    } else if (value ==
                                        'delete') {
                                      setState(
                                          () {
                                        addresses
                                            .removeWhere(
                                          (a) =>
                                              a['id'] ==
                                              address[
                                                  'id'],
                                        );
                                      });
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(
                                            'Address deleted',
                                            style: GoogleFonts
                                                .workSans(
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                            ),
                                          ),
                                          backgroundColor:
                                              Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder:
                                      (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text(
                                          'Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value:
                                          'delete',
                                      child: Text(
                                          'Delete'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              address['address']!,
                              style: GoogleFonts
                                  .workSans(
                                fontSize: 13,
                                fontWeight:
                                    FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            if (address[
                                    'instructions']!
                                .isNotEmpty)
                              Padding(
                                padding: const EdgeInsets
                                    .only(top: 8),
                                child: Text(
                                  'Instructions: ${address['instructions']}',
                                  style: GoogleFonts
                                      .workSans(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w400,
                                    color: Colors
                                        .grey[600],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF13EC5B),
                    minimumSize:
                        const Size(double.infinity,
                            48),
                  ),
                  onPressed: _showAddAddressDialog,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add New Address',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

class SelectAddressMapScreen extends StatefulWidget {
  const SelectAddressMapScreen({super.key});

  @override
  State<SelectAddressMapScreen> createState() =>
      _SelectAddressMapScreenState();
}

class _SelectAddressMapScreenState
    extends State<SelectAddressMapScreen> {
  late GoogleMapController mapController;
  LatLng _selectedLocation =
      const LatLng(6.9271, 80.7789);
  String _selectedAddress = '';
  bool _isLoadingAddress = false;
  bool _mapAvailable = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position =
          await Geolocator.getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.high,
      );

      setState(() {
        _selectedLocation =
            LatLng(position.latitude,
                position.longitude);
      });

      _updateAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Could not get location',
            style: GoogleFonts.workSans(
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    setState(() => _isLoadingAddress = true);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _selectedAddress =
              '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress =
            '$latitude, $longitude';
      });
    } finally {
      setState(() => _isLoadingAddress = false);
    }
  }

  void _onMapTap(LatLng location) {
    setState(() =>
        _selectedLocation = location);
    _updateAddressFromCoordinates(
      location.latitude,
      location.longitude,
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
          child: const Icon(Icons.arrow_back,
              color: Colors.black),
        ),
        title: Text(
          'Select Address',
          style: GoogleFonts.workSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: _mapAvailable ? _buildMapView() : _buildMapPlaceholder(),
    );
  }

  Widget _buildMapView() {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            mapController = controller;
          },
          initialCameraPosition:
              CameraPosition(
            target: _selectedLocation,
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId:
                  const MarkerId('selected'),
              position:
                  _selectedLocation,
              infoWindow: InfoWindow(
                title: 'Selected Location',
                snippet:
                    _selectedAddress,
              ),
            ),
          },
          onTap: _onMapTap,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius
                  .only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(
                          0.1),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Address',
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_isLoadingAddress)
                    const SizedBox(
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation(
                          Color(0xFF13EC5B),
                        ),
                      ),
                    )
                  else
                    Text(
                      _selectedAddress
                              .isEmpty
                          ? 'Tap on map to select address'
                          : _selectedAddress,
                      style: GoogleFonts.workSans(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton
                          .styleFrom(
                        backgroundColor:
                            const Color(
                                0xFF13EC5B),
                        padding:
                            const EdgeInsets
                                .symmetric(
                              vertical: 14,
                            ),
                      ),
                      onPressed:
                          _selectedAddress
                                  .isEmpty
                              ? null
                              : () => Navigator
                                  .pop(
                                context,
                                _selectedAddress,
                              ),
                      child: Text(
                        'Confirm Address',
                        style: GoogleFonts
                            .workSans(
                          color: Colors.white,
                          fontWeight:
                              FontWeight
                                  .w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapPlaceholder() {
    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Map Loading Error',
                  style: GoogleFonts.workSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Google Maps API key required',
                  style: GoogleFonts.workSans(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius
                  .only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(
                          0.1),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Location',
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          BorderRadius.circular(
                              8),
                    ),
                    child: Text(
                      'Latitude: ${_selectedLocation.latitude.toStringAsFixed(4)}\nLongitude: ${_selectedLocation.longitude.toStringAsFixed(4)}',
                      style: GoogleFonts.workSans(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton
                          .styleFrom(
                        backgroundColor:
                            const Color(
                                0xFF13EC5B),
                        padding:
                            const EdgeInsets
                                .symmetric(
                              vertical: 14,
                            ),
                      ),
                      onPressed: () =>
                          Navigator.pop(
                        context,
                        '${_selectedLocation.latitude}, ${_selectedLocation.longitude}',
                      ),
                      child: Text(
                        'Use Current Location',
                        style: GoogleFonts
                            .workSans(
                          color: Colors.white,
                          fontWeight:
                              FontWeight
                                  .w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (_mapAvailable) {
      mapController.dispose();
    }
    super.dispose();
  }
}
