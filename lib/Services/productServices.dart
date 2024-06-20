import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'http://localhost:9000/api';

 static Future getProduct() async {
    http.Response response;
    response = await http.get(Uri.parse('$baseUrl/duab/1')); // Correct way to construct URI

    if (response.statusCode == 200) {
      // Check if response body is valid JSON
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  }
}
