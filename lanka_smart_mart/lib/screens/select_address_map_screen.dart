import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectAddressMapScreen extends StatefulWidget {
  const SelectAddressMapScreen({super.key});

  @override
  State<SelectAddressMapScreen> createState() => _SelectAddressMapScreenState();
}

class _SelectAddressMapScreenState extends State<SelectAddressMapScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  bool _isLoading = true;
  bool _isMapEnabled = false; // Flag to disable GoogleMap when API key is missing

  static const LatLng _defaultLocation = LatLng(6.9271, 79.8612); // Colombo

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        _selectedLocation = LatLng(position.latitude, position.longitude);
        await _getAddressFromLatLng(_selectedLocation!);
        if (_isMapEnabled && _mapController != null) {
          _mapController?.animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
        }
      } else {
        _selectedLocation = _defaultLocation;
        await _getAddressFromLatLng(_selectedLocation!);
      }
    } catch (e) {
      _selectedLocation = _defaultLocation;
      await _getAddressFromLatLng(_selectedLocation!);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _selectedAddress = '${place.street}, ${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'Unable to get address';
      });
    }
  }

  void _confirmAddress() {
    if (_selectedLocation != null && _selectedAddress.isNotEmpty) {
      Navigator.pop(context, _selectedAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Delivery Address',
          style: GoogleFonts.workSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: _isMapEnabled ? _buildMapView() : _buildMapPlaceholder(),
    );
  }

  Widget _buildMapView() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _defaultLocation,
            zoom: 15,
          ),
          onMapCreated: (controller) {
            _mapController = controller;
            if (_selectedLocation != null) {
              _mapController!.animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
            }
          },
          markers: _selectedLocation != null
              ? {
                  Marker(
                    markerId: const MarkerId('selected'),
                    position: _selectedLocation!,
                    infoWindow: InfoWindow(title: _selectedAddress),
                  ),
                }
              : {},
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF13EC5B),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Selected Address',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedAddress,
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _confirmAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13EC5B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Confirm Address',
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
      ],
    );
  }

  Widget _buildMapPlaceholder() {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Map Configuration Required',
                    style: GoogleFonts.workSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Google Maps API key will be available after configuration',
                      style: GoogleFonts.workSans(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Location',
                          style: GoogleFonts.workSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Latitude: ${_selectedLocation?.latitude.toStringAsFixed(4) ?? _defaultLocation.latitude.toStringAsFixed(4)}°',
                          style: GoogleFonts.workSans(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Longitude: ${_selectedLocation?.longitude.toStringAsFixed(4) ?? _defaultLocation.longitude.toStringAsFixed(4)}°',
                          style: GoogleFonts.workSans(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
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
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF13EC5B),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Selected Address',
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _selectedAddress,
                            style: GoogleFonts.workSans(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _confirmAddress,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF13EC5B),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Confirm Address',
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_isMapEnabled && _mapController != null) {
      _mapController?.dispose();
    }
    super.dispose();
  }
}