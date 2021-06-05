class LocationModel {
  static const CODE = 'code';
  static const NAME = 'name';
  static const PINCODE = 'pincode';
  String code;
  String name;
  List pincode;
  LocationModel({this.code, this.name, this.pincode});
  LocationModel.fromMap(Map<String, dynamic> data) {
    code = data[CODE];
    name = data[NAME];
    pincode = data[PINCODE];
  }
}
