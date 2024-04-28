import 'package:flutter/material.dart';
import 'package:story_app/data/service/api_service.dart';
import 'package:story_app/pages/add_story_page.dart';
import 'package:story_app/pages/detail_story_page.dart';
import 'package:story_app/pages/login_page.dart';
import 'package:story_app/pages/register_page.dart';
import 'package:story_app/provider/story_provider.dart';

import '../data/db/auth_repository.dart';
import '../data/model/story.dart';
import '../pages/list_story_page.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(
    this.authRepository,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  String? selectedStory;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isAddStory = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Scaffold(
        body: Center(
          child: Text("Wadh"),
        ),
      );
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: _navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        selectedStory = null;
        isAddStory = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {}

// /// todo 12: add these variable to support history stack

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginPage(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterPage(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("ListStoryPage"),
          child: ListStoryPage(
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
            toDetail: (String storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
            toAddStory: () {
              isAddStory = true;
              notifyListeners();
            },
            story: StoryProvider(authRepository, ApiService()).story ??
                const Story(),
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey("DetailStoryPage-$selectedStory"),
            child: DetailStoryPage(
              storyId: selectedStory ?? "",
            ),
          ),
        if (isAddStory == true)
          MaterialPage(
              key: const ValueKey("AddStoryPage"),
              child: AddStoryPage(
                onBack: () {
                  isAddStory = false;
                  notifyListeners();
                },
              )),
      ];
}
