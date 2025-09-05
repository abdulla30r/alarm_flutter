import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationSection extends StatefulWidget {
  final Map<String, double>? location;
  final String? address;
  final Function(String) onAddressChanged;

  const LocationSection({
    super.key,
    required this.location,
    required this.address,
    required this.onAddressChanged,
  });

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    final lat = widget.location?['latitude'];
    final long = widget.location?['longitude'];

    if (lat != null && long != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          widget.onAddressChanged(
            "${place.street}, ${place.locality}, ${place.country}",
          );
        }
      } catch (_) {
        widget.onAddressChanged("Unable to get address");
      }
    } else {
      widget.onAddressChanged("Location not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 96),
        const Text(
          "Selected Location",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          widget.address ?? "Loading address...",
          style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
