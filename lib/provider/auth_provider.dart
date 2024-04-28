import 'package:flutter/foundation.dart';
import 'package:story_app/data/model/login.dart';
import 'package:story_app/data/model/register.dart';
import 'package:story_app/data/service/api_service.dart';
import '../data/db/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider(this.authRepository);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

  String _message = '';

  String get message => _message;

  String _token = '';

  String get token => _token;

  var apiService = ApiService();

  Future<Login> login(String email, String password) async {
    isLoadingLogin = true;
    notifyListeners();
    try {
      final result = await apiService.login(email, password);
      _token = result.loginResult?.token ?? '';
      isLoggedIn = true;
      await authRepository.saveUser(_token);
      await authRepository.login(); // Sets login
      _message = "Berhasil Login";
      return result;
    } catch (e) {
      isLoggedIn = false;
      _token = '';
      _message = e.toString();
      debugPrint(e.toString());
      return const Login();
    } finally {
      isLoadingLogin = false;
      notifyListeners();
    }
  }

  //register
  Future<Register> register(String name, String email, String password) async {
    isLoadingRegister = true;
    notifyListeners();
    try {
      final result = await apiService.register(name, email, password);
      isLoadingRegister = false;
      notifyListeners();
      return result;
    } catch (e) {
      debugPrint(e.toString());
      _message = "Gagal Register";
      return const Register();
    } finally {
      isLoadingRegister = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    isLoadingLogout = true;
    notifyListeners();
    try {
      await authRepository.logout(); // Resets login state
      _token = '';
      isLoggedIn = false;
      await authRepository.deleteUser();
      notifyListeners();
    } finally {
      isLoadingLogout = false;
      notifyListeners();
    }
  }

  //get user token
  Future<void> getUserToken() async {
    _token = await authRepository.getUser();
    if (kDebugMode) {
      print('Token: $_token');
    }
    notifyListeners();
  }
}
