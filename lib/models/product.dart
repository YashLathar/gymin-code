import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image;
  final String title;
  final int price;
  final String productId;
  bool isLiked;
  int quantity;
  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.productId,
    this.isLiked = false,
    this.quantity = 1,
  });

  Product copyWith({
    String? image,
    String? title,
    int? price,
    String? productId,
    bool? isLiked,
    int? quantity,
  }) {
    return Product(
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      isLiked: isLiked ?? this.isLiked,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'productId': productId,
      'isLiked': isLiked,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      image: map['image'],
      title: map['title'],
      price: map['price'],
      productId: map['productId'],
      isLiked: map['isLiked'],
      quantity: map['quantity'],
    );
  }

  factory Product.fromFirebase(Map<String, dynamic> map, String docId) {
    return Product(
      image: map['image'],
      title: map['title'],
      price: map['price'],
      productId: docId,
      quantity: 1,
    );
  }

  factory Product.fromDocument(DocumentSnapshot doc) {
    final dataMap = doc.data() as Map<String, dynamic>;
    return Product.fromFirebase(dataMap, doc.id);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(image: $image, title: $title, price: $price, productId: $productId, isLiked: $isLiked, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.image == image &&
        other.title == title &&
        other.price == price &&
        other.productId == productId &&
        other.isLiked == isLiked &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        title.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        isLiked.hashCode ^
        quantity.hashCode;
  }
}
