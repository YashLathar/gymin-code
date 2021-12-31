import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductOrder {
  final List<dynamic> productsName;
  final List<dynamic> productsPhotos;
  final int totalPrice;
  final String? docId;
  ProductOrder({
    required this.productsName,
    required this.productsPhotos,
    required this.totalPrice,
    this.docId,
  });

  ProductOrder copyWith({
    List<dynamic>? productsName,
    List<dynamic>? productsPhotos,
    int? totalPrice,
    String? docId,
  }) {
    return ProductOrder(
      productsName: productsName ?? this.productsName,
      productsPhotos: productsPhotos ?? this.productsPhotos,
      totalPrice: totalPrice ?? this.totalPrice,
      docId: docId ?? this.docId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productsName': productsName,
      'productsPhotos': productsPhotos,
      'totalPrice': totalPrice,
      'docId': docId,
    };
  }

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      productsName: List<dynamic>.from(map['productsName']),
      productsPhotos: List<dynamic>.from(map['productsPhotos']),
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      docId: map['docId'],
    );
  }

  factory ProductOrder.mtProductOrder() {
    return ProductOrder(
      productsName: ["not data"],
      totalPrice: 0,
      productsPhotos: ["not data"],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOrder.fromJson(String source) =>
      ProductOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductOrder(productsName: $productsName, productsPhotos: $productsPhotos, totalPrice: $totalPrice, docId: $docId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductOrder &&
        listEquals(other.productsName, productsName) &&
        listEquals(other.productsPhotos, productsPhotos) &&
        other.totalPrice == totalPrice &&
        other.docId == docId;
  }

  @override
  int get hashCode {
    return productsName.hashCode ^
        productsPhotos.hashCode ^
        totalPrice.hashCode ^
        docId.hashCode;
  }
}
