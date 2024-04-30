import 'package:flutter/foundation.dart';
import 'package:story_app/data/service/api_service.dart';

import '../data/db/auth_repository.dart';
import '../data/model/detail_story.dart';
import '../data/model/story.dart';

class StoryProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  StoryProvider(this.authRepository, this.apiService) {
    getStory();
  }

  Story? _story;
  List<ListStory> stories = [];
  Story? get story => _story;
  bool isLoading = false;

  int? pageItems = 1;
  int sizeItems = 10;

  void _setStory(Story story) {
    _story = story;
    notifyListeners();
  }

  Future<Story> getStory() async {
    try {
      if (pageItems == 1) {
        isLoading = true;
        notifyListeners();
      }
      final token = await authRepository.getUser();
      final story = await apiService.getStory(token, pageItems!, sizeItems);
      stories.addAll(story.listStory ?? []);
      if ((story.listStory?.length ?? 0) < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }
      isLoading = false;
      //_setStory(story);
      notifyListeners();
      return story;
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      _setStory(const Story());
      notifyListeners();
      return const Story();
    }
  }

  Future<DetailStory> getDetailStory(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      final token = await authRepository.getUser();
      final result = await apiService.getDetailStory(token, id);
      isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
      return const DetailStory();
    }
  }
}
