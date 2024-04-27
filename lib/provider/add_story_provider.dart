

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryProvider extends ChangeNotifier{
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
}