class DressModel{
  String?name;
  double?total;
  double?rate;
  String?image;
  String?id;

//<editor-fold desc="Data Methods">
  DressModel({
    this.name,
    this.total,
    this.rate,
    this.image,
    this.id,
  });



  DressModel copyWith({
    String? name,
    double? total,
    double? rate,
    String? image,
    String? id,
  }) {
    return DressModel(
      name: name ?? this.name,
      total: total ?? this.total,
      rate: rate ?? this.rate,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'total': this.total,
      'rate': this.rate,
      'image': this.image,
      'id': this.id,
    };
  }

  factory DressModel.fromMap(Map<String, dynamic> map) {
    return DressModel(
      name: map['name'] ??"",
      total: map['total'] ??0.0,
      rate: map['rate'] ??0.0,
      image: map['image'] ??"",
      id: map['id'] ??"",
    );
  }

//</editor-fold>
}