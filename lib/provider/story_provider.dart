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

  Story? get story => _story;
  bool isLoading = false;

  void _setStory(Story story) {
    _story = story;
    notifyListeners();
  }

  Future<Story> getStory() async {
    isLoading = true;
    notifyListeners();
    try {
      final token = await authRepository.getUser();
      final story = await apiService.getStory(token);
      isLoading = false;
      _setStory(story);
      notifyListeners();
      return story;
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      _setStory(Story());
      notifyListeners();
      return Story();
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
      return DetailStory();
    }
  }
}