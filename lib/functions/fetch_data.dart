import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nytimes/configs.dart';
import 'package:nytimes/models/article.dart';
import 'dart:async';

Future<List<Article>> fetchArticles() async {
  final response = await http.get(Uri.parse(
      'https://api.nytimes.com/svc/topstories/v2/technology.json?api-key=$apiKey'));
  List<Article> list;
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var data = json.decode(response.body);
    var rest = data["results"] as List;
    list = rest.map<Article>((json) => Article.fromJson(json)).toList();

    return list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load articles');
  }
}
