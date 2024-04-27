
import 'package:flutter/material.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/data/model/detail_story.dart';

import '../data/service/api_service.dart';


class DetailStoryProvider extends ChangeNotifier {
  final String storyId;

  DetailStoryProvider({required this.storyId}) {
    getDetailStory(storyId);
  }

  late DetailStory _detailStory;

  DetailStory get detailStory => _detailStory;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late String _message;

  String get message => _message;

  final ApiService apiService = ApiService();

  Future<DetailStory> getDetailStory(String id) async {
    try {
      _isLoading = true;
      notifyListeners();
      final token = await AuthRepository().getUser();
      _detailStory = await apiService.getDetailStory(token, id);
      _isLoading = false;
      _message = _detailStory.message ?? '';
      notifyListeners();
      return _detailStory;
    } catch (e) {
      _message = e.toString();
      _isLoading = false;
      notifyListeners();
      return DetailStory();
    }
  }
}
