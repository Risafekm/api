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

  addData(context) async {
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
        snackbar(context);
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
    Uri updateUrl =
        Uri.parse('http://localhost/radiant/update.php?mtest_id=$i');
    var data = Tests(
      mTestId: i,
      modNum: int.parse(editmodIdController.text),
      userId: int.parse(edituserIdController.text),
      status: int.parse(statusController.text),
      mTestPoints: int.parse(mtestPointsController.text),
    );

    try {
      var response = await http.put(
        updateUrl,
        body: jsonEncode(data.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await getData();
        print(" update success ${response.body}");
      }
    } catch (e) {
      print('Error updated failed: ${e.toString()}');
    }
    notifyListeners();
  }

  //delete

  deleteData(String i, context) async {
    Uri deleteUrl =
        Uri.parse('http://localhost/radiant/delete.php?mtest_id=$i');

    var response = await http.delete(deleteUrl);
    if (response.statusCode == 200) {
      snackbar(context);
      getData();

      print('Successfully deleted');
    }
  }

  clear() {
    modIdController.clear();
    userIdController.clear();
    statusController.clear();
    mtestPointsController.clear();
  }
  //snackBar

  snackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blue,
        content: Row(
          children: [
            Expanded(child: Text('Deleted Successfully')),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.done, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
