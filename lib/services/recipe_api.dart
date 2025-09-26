import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<dynamic>> fetchRecipes() async {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/recipes"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['recipes']; // return only the list
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}
