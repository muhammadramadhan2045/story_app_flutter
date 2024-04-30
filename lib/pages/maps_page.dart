import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:provider/provider.dart';
import 'package:story_app/provider/add_story_provider.dart';

class MapsPage extends StatefulWidget {
  final Function() onBack;
  const MapsPage({super.key, required this.onBack});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;
  geo.Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<AddStoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picker Screen'),
      ),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) {
                mapController = controller;
              },
              onLongPress: onLongPressGoogleMap,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-6.8957473, 107.6337669),
                zoom: 15,
              ),
              markers: mapProvider.markers,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                child: const Icon(Icons.my_location),
                onPressed: () => onMyLocationButtonPress(context),
              ),
            ),

            // Button to back
            Positioned(
              bottom: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () => widget.onBack(),
                  icon: const Icon(Icons.done),
                  label: const Text('Done'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    Provider.of<AddStoryProvider>(context, listen: false).clearMarkers();
    Provider.of<AddStoryProvider>(context, listen: false).addMarker(marker);
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final mapProvider = Provider.of<AddStoryProvider>(context, listen: false);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });
    defineMarker(latLng, street, address);
    mapProvider.setLatLon(
      latLng.latitude,
      latLng.longitude,
    );

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress(BuildContext context) async {
    final Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        debugPrint("Location services are not available");
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        debugPrint("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    final mapProvider = Provider.of<AddStoryProvider>(context, listen: false);
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });

    mapProvider.setLatLon(
      latLng.latitude,
      latLng.longitude,
    );
    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
