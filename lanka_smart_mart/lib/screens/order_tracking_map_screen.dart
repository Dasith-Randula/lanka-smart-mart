import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTrackingMapScreen extends StatefulWidget {
  const OrderTrackingMapScreen({super.key});

  @override
  State<OrderTrackingMapScreen> createState() => _OrderTrackingMapScreenState();
}

class _OrderTrackingMapScreenState extends State<OrderTrackingMapScreen> {
  GoogleMapController? _mapController;
  LatLng _orderLocation = const LatLng(6.9271, 79.8612); // Colombo
  LatLng _userLocation = const LatLng(6.9271, 79.8612); // Same for demo

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
          'Order Tracking',
          style: GoogleFonts.workSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _orderLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId('order'),
                position: _orderLocation,
                infoWindow: const InfoWindow(title: 'Order Location'),
              ),
              Marker(
                markerId: const MarkerId('user'),
                position: _userLocation,
                infoWindow: const InfoWindow(title: 'Your Location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Zoom Controls
          Positioned(
            right: 16,
            top: 100,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          // Track Button
          Positioned(
            right: 16,
            bottom: 120,
            child: FloatingActionButton(
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLng(_orderLocation),
                );
              },
              child: const Icon(Icons.my_location),
            ),
          ),
          // Arriving Time Box
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arriving in',
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '15 minutes',
                        style: GoogleFonts.workSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.delivery_dining,
                    size: 32,
                    color: Color(0xFF13EC5B),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}