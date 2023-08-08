import 'photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Search {

  static const apiKey = "oN4trq6sXKd5qnQnZf7RsfD77kG7NYezL1kpD7yNLpkslaV237YKTOz4";
  String uri = "https://api.pexels.com/v1/search?query=";

  Future<List<Photo>> search(String query) async {
    print(query);
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