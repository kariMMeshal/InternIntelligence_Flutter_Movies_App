import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class KHttpHelper {
  static String baseUrl = dotenv.env['BASE_URL'] ?? 'https://default.url';
  static String apiKey = dotenv.env['API_KEY'] ?? '';

  static Future<Map<String, dynamic>> get({
    required String endpoint,
    String bonusEndpoint = "",
  }) async {
    final uri = Uri.parse("$baseUrl/${endpoint}api_key=$apiKey$bonusEndpoint");

    final response =
        await http.get(uri, headers: {"Accept": "application/json"});
    print('API URL: $uri');
    // print('Response: ${response.body}');
    return handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {"content-Type": "app/json"},
      body: json.encode(data),
    );
    return handleResponse(response);
  }

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {"content-Type": "app/json"},
      body: json.encode(data),
    );
    return handleResponse(response);
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse("$baseUrl/$endpoint"));
    return handleResponse(response);
  }

  static Map<String, dynamic> handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      // print("--------success-----------${response.body}");
      return json.decode(response.body);
    } else {
      // print("-----------------${response.statusCode}==========");
      throw Exception("Failed To Load Data ${response.statusCode}");
    }
  }
}
