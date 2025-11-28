import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pizza.dart';

class HttpHelper {
  // Singleton setup
  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  final String authority = '02z2g.mocklab.io';
  final String path = 'pizzalist';

  Future<List<Pizza>> getPizzaList() async {
    final Uri url = Uri.https(authority, path);
    final http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      // Expecting a list of items
      List<Pizza> pizzas = (jsonResponse as List)
          .map<Pizza>((i) => Pizza.fromJson(i as Map<String, dynamic>))
          .toList();
      return pizzas;
    } else {
      return [];
    }
  }
}
