import 'dart:convert';

class Product {
  final String image;
  final String title;
  final int price;
  final String productId;
  int quantity;
  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.productId,
    this.quantity = 1,
  });

  Product copyWith({
    String? image,
    String? title,
    int? price,
    String? productId,
    int? quantity,
  }) {
    return Product(
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      image: map['image'],
      title: map['title'],
      price: map['price'],
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(image: $image, title: $title, price: $price, productId: $productId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.image == image &&
        other.title == title &&
        other.price == price &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        title.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        quantity.hashCode;
  }
}
