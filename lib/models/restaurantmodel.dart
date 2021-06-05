class RestaurantModel {
  static const ADDRESS = 'address';
  static const CLOSED = 'closed';
  static const RANGE = 'deliveryrange';
  static const LATITUDE = 'latitude';
  static const PHOTOURL = 'photo_url';
  static const LONGITUDE = 'longitude';
  static const NAME = 'name';
  static const PHONE = 'phone';
  static const TAX = 'tax';
  static const USERNAME = 'username';
  static const FOOD = 'food';

  // List<Product> productList = [];
  String address;
  String image;
  bool closed;
  var range;
  var latitude;
  var longitude;
  String name;
  String phone;
  var tax;
  String username;
  List<FoodModel> food;
  RestaurantModel(
      {this.address,
      this.closed,
      this.range,
      this.latitude,
      this.longitude,
      this.name,
      this.phone,
      this.tax,
      this.username,
        this.image,
      this.food});

  List<FoodModel> _convertfood(List food) {
    List<FoodModel> _result = [];
    if (food.length > 0) {
      food.forEach((element) {
        _result.add(FoodModel.fromMap(element));
      });
    }
    return _result;
  }

  RestaurantModel.fromMap(Map<String, dynamic> data) {
    address = data[ADDRESS];
    closed = data[CLOSED];
    range = data[RANGE];
    latitude = data[LATITUDE];
    longitude = data[LONGITUDE];
    name = data[NAME];
    phone = data[PHONE];
    tax = data[TAX];
    username = data[USERNAME];
    image = data[PHOTOURL];
    food = _convertfood(data[FOOD] ?? []);
  }
}

class FoodModel {
  static const CATEGORY = 'category';
  static const COUNT = 'count';
  static const DISTCOUNTPRICE = 'discountprice';
  static const FEATURED = 'featured';
  static const ISDELIVERABLE = 'isdeliverable';
  static const NAME = 'name';
  static const ONDISCOUNT = 'ondiscount';
  static const PHOTOURL = 'photo_url';
  static const PRICE = 'price';
  static const UNIT = 'unit';
  static const WEIGHT = 'weight';
  String category;
  var count;
  var discountprice;
  bool featured;
  bool isdeliverable;
  String name;
  bool ondiscount;
  String photourl;
  var price;
  var unit;
  var weight;
  FoodModel(
      {this.category,
      this.count,
      this.discountprice,
      this.featured,
      this.isdeliverable,
      this.name,
      this.ondiscount,
      this.photourl,
      this.price,
      this.unit,
      this.weight});
  FoodModel.fromMap(Map<String, dynamic> data) {
    category = data[CATEGORY];
    count = data[COUNT];
    discountprice = data[DISTCOUNTPRICE];
    featured = data[FEATURED];
    isdeliverable = data[ISDELIVERABLE];
    name = data[NAME];
    ondiscount = data[ONDISCOUNT];
    photourl = data[PHOTOURL];
    price = data[PRICE];
    unit = data[UNIT];
    weight = data[WEIGHT];
  }

  Map<String, dynamic> toJson() => {
        CATEGORY: category,
        COUNT: count,
        DISTCOUNTPRICE: discountprice,
        FEATURED: featured,
        ISDELIVERABLE: isdeliverable,
        NAME: name,
        ONDISCOUNT: ondiscount,
        PHOTOURL: photourl,
        PRICE: price,
        UNIT: unit,
        WEIGHT: weight,
      };
}
