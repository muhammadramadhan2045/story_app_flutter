import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:story_app/data/model/detail_story.dart';
import 'package:story_app/data/model/story.dart';
import 'package:story_app/data/model/login.dart';

import '../model/add_story.dart';
import '../model/register.dart';

class ApiService {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1/';

  //login
  Future<Login> login(String email, String password) async {
    final response =
        await http.post(Uri.parse('${baseUrl}login'), body: <String, String>{
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return Login.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  //register
  Future<Register> register(String name, String email, String password) async {
    final response =
        await http.post(Uri.parse('${baseUrl}register'), body: <String, String>{
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 201) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  //get story
  Future<Story> getStory(String token, [int page = 1, int size = 10]) async {
    final response = await http.get(
      Uri.parse('${baseUrl}stories?page=$page&size=$size'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return Story.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load story');
    }
  }

  //get detail story
  Future<DetailStory> getDetailStory(String token, String id) async {
    final response = await http.get(
      Uri.parse('${baseUrl}stories/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return DetailStory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail story');
    }
  }

  //add story as guest
  Future<AddStory> uploadDocumentAsGuest(
    List<int> bytes,
    String fileName,
    String description,
    String token, [
    String? lat,
    String? lon,
  ]) async {
    const String url = "https://story-api.dicoding.dev/v1/stories";

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    //add headers Content-Type: multipart/form-data
    //Authorization

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );
    final Map<String, String> fields = {
      "description": description,
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    };

    // Tambahkan lat dan lon ke fields hanya jika mereka tidak null
    if (lat != null && lon != null) {
      fields.addAll({"lat": lat, "lon": lon});
    }

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      final AddStory addStory = AddStory.fromJson(jsonDecode(responseData));
      return addStory;
    } else {
      throw Exception("Upload file error");
    }
  }
}
