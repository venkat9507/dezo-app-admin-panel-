import 'dart:async';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  RxList<UserModel> users = RxList<UserModel>([]);
  RxInt pageindex = 0.obs;
  final PageController controller = PageController(initialPage: 2);
  String collection = "users";

  @override
  onReady() {
    super.onReady();
    users.bindStream(getAllOrders());
  }

  Stream<List<UserModel>> getAllOrders() =>
      firebaseFirestore.collection('users').snapshots().map((query) =>
          query.docs.map((item) => UserModel.fromSnapshot(item)).toList());
}
