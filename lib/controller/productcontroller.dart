import 'dart:async';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/models/productmodel.dart';
import 'package:get/get.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<ProductModel> categorisedproducts = RxList<ProductModel>([]);
  // String collection = "products";
  RxList categories = RxList([]);
  RxList carousel = RxList([]);

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
    categories.bindStream(getCategoryLists());
    carousel.bindStream(getCarousalLists());
  }

  Stream<List> getCategoryLists() => firebaseFirestore
      .collection('category')
      .doc('categories')
      .snapshots()
      .map((query) => query.get('cat_name'));

  Stream<List> getCarousalLists() => firebaseFirestore
      .collection('category')
      .doc('carousel')
      .snapshots()
      .map((query) => query.get('photourl'));

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection("products").snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}
