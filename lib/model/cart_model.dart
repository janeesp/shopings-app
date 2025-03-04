class CartModel{
  String?name;
  double?total;
  double?rate;
  String?image;
  String?productId;
  String?id;
  int?quantity;

//<editor-fold desc="Data Methods">
  CartModel({
    this.name,
    this.total,
    this.rate,
    this.image,
    this.productId,
    this.id,
    this.quantity,
  });


  CartModel copyWith({
    String? name,
    double? total,
    double? rate,
    String? image,
    String? id,
    String? productId,
    int? quantity,
  }) {
    return CartModel(
      name: name ?? this.name,
      total: total ?? this.total,
      rate: rate ?? this.rate,
      image: image ?? this.image,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'total': this.total,
      'rate': this.rate,
      'image': this.image,
      'id': this.id,
      'productId': this.productId,
      'quantity': this.quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      name: map['name'] ??"",
      total: map['total'] ??0.0,
      rate: map['rate'] ??0.0,
      image: map['image'] ??"",
      id: map['id'] ??"",
      productId: map['productId'] ??"",
      quantity: map['quantity'] ??1,
    );
  }

//</editor-fold>
}