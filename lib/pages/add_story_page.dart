import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/provider/add_story_provider.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../provider/story_provider.dart';
import '../provider/upload_provider.dart';

class AddStoryPage extends StatefulWidget {
  final Function() onBack;
  final Function() toMaps;
  const AddStoryPage({super.key, required this.onBack, required this.toMaps});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final descController = TextEditingController();
  late GoogleMapController mapController;
  geo.Placemark? placemark;

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<AddStoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _onUpload();
              },
              icon: const Icon(Icons.file_upload_outlined)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: context.watch<AddStoryProvider>().imagePath == null
                    ? const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      )
                    : _showImage(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Description is required";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  widget.toMaps();
                },
                icon: const Icon(
                  Icons.location_on_outlined,
                ),
                label: mapProvider.lat != null && mapProvider.lon != null
                    ? const Text("Change location")
                    : const Text("Input location"),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _onGalleryView(),
                      child: const Text("Gallery"),
                    ),
                    ElevatedButton(
                      onPressed: () => _onCameraView(),
                      child: const Text("Camera"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onUpload() async {
    debugPrint("Upload diklik");
    final provider = context.read<AddStoryProvider>();
    final uploadProvider = context.read<UploadProvider>();
    final storyProvider = context.read<StoryProvider>();
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final imagePath = provider.imagePath;
    final imageFile = provider.imageFile;
    if (imagePath == null && imageFile == null) return;

    final fileName = imageFile!.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes = await uploadProvider.compressImage(bytes);

    provider.lat != null && provider.lon != null
        ? await uploadProvider.uploadImage(
            newBytes,
            fileName,
            descController.text,
            provider.lat.toString(),
            provider.lon.toString())
        : await uploadProvider.uploadImage(
            newBytes, fileName, descController.text);

    if (uploadProvider.uploadResponse != null) {
      provider.setImageFile(null);
      provider.setImagePath(null);
    }

    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(uploadProvider.message)),
    );
    storyProvider.getStory();
    widget.onBack();
    provider.clearLatLon();
  }

  _onGalleryView() async {
    final ImagePicker picker = ImagePicker();
    final provider = context.read<AddStoryProvider>();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final ImagePicker picker = ImagePicker();
    final provider = context.read<AddStoryProvider>();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.watch<AddStoryProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }
}
