// ignore_for_file: unused_local_variable, avoid_print, prefer_final_fields

import 'dart:convert';

import 'package:api/model/test_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  List<Tests> _posts = [];
  List<Tests> get posts => _posts;

  final String apiUrl = 'http://localhost/php-prac/inserttests.php';

  TextEditingController modIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  addUser() async {
    var userdata = Tests(
      modNum: int.parse(modIdController.text),
      userId: int.parse(userIdController.text),
      status: int.parse(statusController.text),
      mTestId: null,
    );
    var bodyy = jsonEncode(userdata);
    var response = await http.post(
      Uri.parse(apiUrl),
      body: bodyy,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('successfully posted');
      var dataa = jsonDecode(response.body);
      print('Response body: $dataa');
    } else {}
  }
}
