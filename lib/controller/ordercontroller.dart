import 'dart:async';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/models/ordermodel.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  String collection = "orders";

  @override
  onReady() {
    super.onReady();
    orders.bindStream(getAllOrders());
  }

  Stream<List<OrderModel>> getAllOrders() => firebaseFirestore
      .collection('orders')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());
}
