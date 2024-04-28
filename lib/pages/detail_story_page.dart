import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/detail_story_provider.dart';

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
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
