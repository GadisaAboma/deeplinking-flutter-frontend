class Product {
  String? id;
  String? name;
  String? description;
  double? costPrice;
  double? averageRate;
  String? image;
  bool? isFeatured;

  Product(
      {this.id,
      this.name,
      this.description,
      this.costPrice,
      this.image,
      this.averageRate,
      this.isFeatured});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        costPrice: json['costPrice'] is int
            ? (json['costPrice']).toDouble()
            : json['costPrice'],
        averageRate: json['averageRate'] != null
            ? json['averageRate']['rate'] is int
                ? (json['averageRate']['rate']).toDouble()
                : json['averageRate']['rate']
            : .0,
        image: json['image'],
        isFeatured: json['isFeatured']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'costPrice': costPrice,
      'averageRate': averageRate != null ? {'rate': averageRate} : null,
      'minioProductImages': image,
      'isFeatured': isFeatured
    };
  }
}
