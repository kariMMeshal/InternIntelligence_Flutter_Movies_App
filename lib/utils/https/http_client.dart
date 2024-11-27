import 'dart:convert';

import 'package:http/http.dart' as http;

class KHttpHelper {
  static const String baseUrl = "https://api.themoviedb.org";
  static const String apiKey = "b2207859d08db5770d857929a86290bc";

  static Future<Map<String, dynamic>> get(String endpoint) async {
    // Build the request URI
    final uri = Uri.parse("$baseUrl/${endpoint}api_key=$apiKey");

    final response =
        await http.get(uri, headers: {"Accept": "application/json"});
    // Handle the response
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
