// ignore_for_file: unused_local_variable

import 'package:api/model/test_model.dart';
import 'package:api/services/get_provider_service.dart';
import 'package:flutter/material.dart';

class ProviderOperation extends ChangeNotifier {
  final service = ProviderService();
  bool isLoding = false;
  List<Tests> _posts = [];
  List<Tests> get posts => _posts;
  getAllPosts() async {
    isLoding = true;
    notifyListeners();
    final res = await service.getAll();
    _posts = res;
    isLoding = false;
    notifyListeners();
  }
}
