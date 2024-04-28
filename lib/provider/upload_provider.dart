import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:story_app/data/model/add_story.dart';
import 'package:image/image.dart' as img;
import '../data/db/auth_repository.dart';
import '../data/service/api_service.dart';

class UploadProvider extends ChangeNotifier {
  final ApiService apisService;

  UploadProvider({required this.apisService});

  bool isUploading = false;
  String message = "";
  AddStory? uploadResponse;

  Future<void> uploadImage(
      List<int> bytes, String fileName, String description) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();

      final token = await AuthRepository().getUser();
      uploadResponse = await apisService.uploadDocumentAsGuest(
          bytes, fileName, description, token);
      message = uploadResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      isUploading = false;
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      ///
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
