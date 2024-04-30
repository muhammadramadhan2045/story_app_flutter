import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/detail_story_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailStoryPage extends StatelessWidget {
  final String storyId;

  const DetailStoryPage({super.key, required this.storyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Story'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ChangeNotifierProvider(
            create: (_) => DetailStoryProvider(storyId: storyId),
            child: Consumer<DetailStoryProvider>(builder: (context, state, _) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/placeholder.png",
                            image: state.detailStory.story?.photoUrl ?? "",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(state.detailStory.story?.name ?? ""),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(state.detailStory.story?.description ?? ""),
                        const SizedBox(
                          height: 8,
                        ),
                        if (state.detailStory.story?.lat != null &&
                            state.detailStory.story?.lon != null)
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GoogleMap(
                              onMapCreated: (controller) async {
                                final info = await geo.placemarkFromCoordinates(
                                    state.detailStory.story?.lat ?? 0,
                                    state.detailStory.story?.lon ?? 0);
                                final place = info[0];
                                final street = place.street!;
                                final address =
                                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                                state.addMarker(
                                  LatLng(
                                    state.detailStory.story?.lat ?? 0,
                                    state.detailStory.story?.lon ?? 0,
                                  ),
                                  street,
                                  address,
                                );
                              },
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  state.detailStory.story?.lat ?? 0,
                                  state.detailStory.story?.lon ?? 0,
                                ),
                                zoom: 15,
                              ),
                              markers: state.markers,
                            ),
                          ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
