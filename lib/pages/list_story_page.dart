import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/model/story.dart';
import 'package:story_app/provider/story_provider.dart';

import '../provider/auth_provider.dart';

class ListStoryPage extends StatefulWidget {
  final Story story;
  final Function() onLogout;
  final Function(String) toDetail;
  final Function() toAddStory;

  const ListStoryPage({
    super.key,
    required this.onLogout,
    required this.toDetail,
    required this.toAddStory,
    required this.story,
  });

  @override
  State<ListStoryPage> createState() => _ListStoryPageState();
}

class _ListStoryPageState extends State<ListStoryPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final storyP = context.read<StoryProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storyP.pageItems != null) storyP.getStory();
      }
    });

    Future.microtask(() async => storyP.getStory());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Story'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.toAddStory,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, _) {
          return storyProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: scrollController,
                  itemCount: storyProvider.stories.length +
                      (storyProvider.pageItems != null ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == storyProvider.stories.length &&
                        storyProvider.pageItems != null) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final story = storyProvider.stories[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: FadeInImage.assetNetwork(
                          placeholder: "assets/placeholder.png",
                          image: story.photoUrl ?? "",
                          width: 50,
                          height: 50,
                        ),
                        title: Text(story.name ?? ""),
                        subtitle: Text(
                          story.description ?? "",
                          maxLines: 1,
                        ),
                        onTap: () {
                          widget.toDetail(story.id ?? "");
                        },
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final authRead = context.read<AuthProvider>();
          await authRead.logout().then((value) {
            widget.onLogout();
          });
        },
        tooltip: "Logout",
        child: authWatch.isLoadingLogout
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.logout),
      ),
    );
  }
}
