// ignore_for_file: unused_local_variable

import 'package:api/model/test_model.dart';
import 'package:api/services/provider_service.dart';
import 'package:flutter/material.dart';

class ProviderOperation extends ChangeNotifier {
  final sevice = ProviderService();
  bool isLoding = false;
  List<Tests> _posts = [];
  List<Tests> get posts => _posts;
  getAllPosts() async {
    isLoding = true;
    notifyListeners();
    final res = await sevice.getAll();
    _posts = res;
    isLoding = false;
    notifyListeners();
  }

  SendActivity(var body) async {
    isLoding = true;
    notifyListeners();
    final res = await sevice.postMethod(body);
    var data = res;
    isLoding = false;
    notifyListeners();
  }
}
