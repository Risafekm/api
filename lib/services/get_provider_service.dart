import 'dart:convert';
import 'package:api/model/test_model.dart';
import 'package:http/http.dart' as http;

class ProviderService {
  static const baseUrl =
      'http://localhost/php-prac/edu_module_tests.php?modId=2';

  Future<List<Tests>> getAll() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          final testsList = jsonData.map((e) => Tests.fromJson(e)).toList();
          return testsList;
        } else {
          print('Unexpected response format.');
          return [];
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
