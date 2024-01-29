// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api/model/test_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<Tests> _posts = [];
  List<Tests> get posts => _posts;
  bool isLoding = false;

  // post controller
  TextEditingController modIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController mtestPointsController = TextEditingController();

  //update Controller

  TextEditingController editmodIdController = TextEditingController();
  TextEditingController edituserIdController = TextEditingController();
  TextEditingController editstatusController = TextEditingController();
  TextEditingController editmtestPointsController = TextEditingController();

//post Data

  addData() async {
    String apiUrl = 'http://localhost/radiant/create.php';
    var userdata = Tests(
      modNum: int.parse(modIdController.text),
      userId: int.parse(userIdController.text),
      status: int.parse(statusController.text),
      mTestPoints: int.parse(mtestPointsController.text),
      mTestId: null,
    );
    try {
      var bodyy = jsonEncode(userdata);
      var response = await http.post(
        Uri.parse(apiUrl),
        body: bodyy,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print('successfully posted');
        var dataa = jsonDecode(response.body);
        await getData();
        print('Response body: $dataa');
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

//get Data

  getData() async {
    isLoding = true;
    String getUrl = 'http://localhost/radiant/read.php';
    try {
      var response = await http.get(Uri.parse(getUrl));
      if (response.statusCode == 200) {
        var data = List<Tests>.from(
            jsonDecode(response.body).map((e) => Tests.fromJson(e))).toList();
        if (data != null) {
          _posts = data;
          isLoding = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //update data

  updateData(int i) async {
    String updateUrl = 'http://localhost/radiant/update.php?mtest_id=$i';
    var data = Tests(
      mTestId: i,
      modNum: int.parse(editmodIdController.text),
      userId: int.parse(edituserIdController.text),
      status: int.parse(statusController.text),
      mTestPoints: int.parse(mtestPointsController.text),
    );

    try {
      var response = await http.put(
        Uri.parse(updateUrl),
        body: jsonEncode(data.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await getData();
        print(" update success ${response.body}");
        notifyListeners();
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
    notifyListeners();
  }

  // void updateData(int mTestId) {
  //   // Find the test with the specified mTestId
  //   Tests? test = _posts.firstWhere((test) => test.mTestId == mTestId);

  //   if (test != null) {
  //     // Update the properties of the test
  //     test.modNum = int.tryParse(editmodIdController.text) ?? test.modNum;
  //     test.userId = int.tryParse(edituserIdController.text) ?? test.userId;
  //     test.mTestPoints =
  //         int.tryParse(editmtestPointsController.text) ?? test.mTestPoints;
  //     test.status = int.tryParse(editstatusController.text) ?? test.status;

  //     // Notify listeners to update the UI
  //     notifyListeners();
  //   }
  // }

  clear() {
    modIdController.clear();
    userIdController.clear();
    statusController.clear();
    mtestPointsController.clear();
  }
}
