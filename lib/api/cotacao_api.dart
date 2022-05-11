import 'dart:convert';
import 'package:bytebank/api/post.dart';
import 'package:http/http.dart' as http;

class CotacaoAPI {
  final Uri _url =
      Uri.parse("https://api.hgbrasil.com/finance?format=json&key=dc60ae1f");

  Future<Post> fetchPost() async {
    final response =
        await http.get(_url);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
