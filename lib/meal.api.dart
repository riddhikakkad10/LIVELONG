import 'dart:convert';
import 'package:http/http.dart' as http;

class MealApi {
  static const String _baseUrl =
      'https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition';
  static const String _apiKey = 'd8bb8cd957msh4f341a92d5d6668p13aa5fjsn4e6ce205f74e';

  static Future<Map<String, dynamic>> fetchNutritionInfo(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?query=$query'),
      headers: {
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final dynamic jsonData = jsonDecode(response.body);

      // Check if the response is a list (if so, return the first item)
      if (jsonData is List) {
        if (jsonData.isNotEmpty) {
          return jsonData.first;
        } else {
          throw Exception('Empty response returned');
        }
      } else {
        return jsonData;
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load nutrition information');
    }
  }
}
