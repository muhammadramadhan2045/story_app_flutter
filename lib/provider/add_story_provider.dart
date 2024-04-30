import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryProvider extends ChangeNotifier {
  String? imagePath;

  XFile? imageFile;

  void setImagePath(String? path) {
    imagePath = path;
    notifyListeners();
  }

  void setImageFile(XFile? file) {
    imageFile = file;
    notifyListeners();
  }

  Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  void addMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void clearMarkers() {
    _markers.clear();
    notifyListeners();
  }

  //set lat lon
  double? lat;
  double? lon;

  void setLatLon(double? lat, double? lon) {
    this.lat = lat;
    this.lon = lon;
    notifyListeners();
  }

  void clearLatLon() {
    lat = null;
    lon = null;
    notifyListeners();
  }
}
