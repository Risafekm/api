import 'dart:convert';

import 'package:api/model/test_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProvider with ChangeNotifier {
  List<Tests> _posts = [];
  List<Tests> get posts => _posts;

  final String apiUrl = 'http://localhost/radiant/update.php';

  TextEditingController modIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController mtestPointsController = TextEditingController();

  updateUser(int mTestId) async {
    var userdata = Tests(
      modNum: int.parse(modIdController.text),
      userId: int.parse(userIdController.text),
      status: int.parse(statusController.text),
      mTestPoints: int.parse(mtestPointsController.text),
      mTestId: mTestId,
    );
    var bodyy = jsonEncode(userdata);
    var urlWithId = Uri.parse('$apiUrl?mtest_id=$mTestId');
    var response = await http.put(
      urlWithId,
      body: bodyy,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Successfully updated');
      var dataa = jsonDecode(response.body);
      print('Response body: $dataa');
      notifyListeners();
    } else {
      print('Update failed');
    }
  }
}
