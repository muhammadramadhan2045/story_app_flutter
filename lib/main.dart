import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/add_story_provider.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/provider/upload_provider.dart';
import 'package:story_app/routes/router_delegate.dart';

import 'data/db/auth_repository.dart';
import 'data/service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();

    authProvider = AuthProvider(authRepository);

    /// todo 7: inject auth to router delegate
    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => authProvider,
        ),
        ChangeNotifierProvider<StoryProvider>(
          create: (context) => StoryProvider(
            authProvider.authRepository,
            ApiService(),
          ),
        ),
        ChangeNotifierProvider<UploadProvider>(
          create: (context) => UploadProvider(apisService: ApiService()),
        ),
        ChangeNotifierProvider(create: (context) => AddStoryProvider())
      ],
      child: MaterialApp(
        title: 'Story App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
