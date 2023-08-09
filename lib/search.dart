/// Jason McMillan

import 'photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search {

  static const apiKey = "oN4trq6sXKd5qnQnZf7RsfD77kG7NYezL1kpD7yNLpkslaV237YKTOz4"; // This should typically be removed before committing but keeping for easy testing
  String uri = "https://api.pexels.com/v1/search?query=";

  /// API call using pexels to get list of photos based on input query
  Future<List<Photo>> search(String query) async {
    final response = await http.get(
      Uri.parse(uri + query),
      headers: {
        'Authorization' : apiKey
      }
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> photoList = data['photos'];
      return photoList.map((p) => Photo.fromJson(p)).toList();
    }
    else {
      throw Exception('Error: failed to load photos');
    }
  }
}