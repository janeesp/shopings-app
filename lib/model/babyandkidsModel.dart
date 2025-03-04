class BabyModel{
  String?name;
  String?catogery;
  double?total;
  double?rate;
  String?image;
  String?id;

//<editor-fold desc="Data Methods">
  BabyModel({
    this.name,
    this.catogery,
    this.total,
    this.rate,
    this.image,
    this.id,
  });


  BabyModel copyWith({
    String? name,
    String? catogery,
    double? total,
    double? rate,
    String? image,
    String? id,
  }) {
    return BabyModel(
      name: name ?? this.name,
      catogery: catogery ?? this.catogery,
      total: total ?? this.total,
      rate: rate ?? this.rate,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'catogery': this.catogery,
      'total': this.total,
      'rate': this.rate,
      'image': this.image,
      'id': this.id,
    };
  }

  factory BabyModel.fromMap(Map<String, dynamic> map) {
    return BabyModel(
      name: map['name'] as String,
      catogery: map['catogery'] as String,
      total: map['total'] as double,
      rate: map['rate'] as double,
      image: map['image'] as String,
      id: map['id'] as String,
    );
  }

//</editor-fold>
}