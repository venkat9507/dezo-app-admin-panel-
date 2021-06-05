import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const PHOTO = "photo";
  static const NAME = "name";
  static const EMAIL = "phone";
  static const CART = "cart";
  static const ADDRESS = "address";
  static const PINCODE = "pincode";
  // static const WHISHLIST = 'whishlist';

  String id;
  String name;
  String phone;
  String photo;
  String address;
  String pincode;

  UserModel({this.id, this.name, this.phone, this.address, this.photo});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    phone = snapshot.data()[EMAIL];
    id = snapshot.data()[ID];
    photo = snapshot.data()[PHOTO];
    address = snapshot.data()[ADDRESS];
    pincode = snapshot.data()[PINCODE];
    // whishlist = snapshot.data()[WHISHLIST];
  }
}
