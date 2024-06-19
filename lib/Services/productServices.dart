import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductAPI {
  static final String url = 'https://dummyjson.com';

  static Future<Map<String, dynamic>> getProduct() async {
    final response = await http.get(Uri.parse('$url/products'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load post');
    }
  }
}

 