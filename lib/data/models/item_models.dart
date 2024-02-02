import 'dart:convert';
import './common_models.dart';

class ProductModel {
  final String id;
  final String name;
  final ImageModel image;
  final String itemType;
  final String type;
  final String? category;
  final String? unit;
  final String? sku;
  final String? barcode;
  final double? price;
  final int? stock;
  final dynamic variations;
  final dynamic attributes;
  final String? description;
  final bool? nonTaxable;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.itemType,
    required this.type,
    this.category,
    this.unit,
    this.sku,
    this.barcode,
    this.price,
    this.stock,
    this.variations,
    this.attributes,
    this.description,
    this.nonTaxable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      image: ImageModel.fromMap(map['image'] ?? {}),
      itemType: map['itemType'],
      type: map['type'],
      category: map['category']?['id'],
      unit: map['unit']?['id'],
      sku: map['sku'],
      barcode: map['barcode'],
      price: map['price']?.toDouble(),
      stock: map['stock'],
      variations: map['variations'] ?? {},
      attributes: map['attributes'] ?? {},
      description: map['description'],
      nonTaxable: map['nonTaxable'] ?? false,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image.toMap(),
      'itemType': itemType,
      'type': type,
      'category': category,
      'unit': unit,
      'sku': sku,
      'barcode': barcode,
      'price': price,
      'stock': stock,
      'variations': variations,
      'description': description,
      'nonTaxable': nonTaxable,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}

class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}

class UnitModel {
  final String id;
  final String name;
  final String shortName;
  final String? description;
  final String createdAt;
  final String updatedAt;

  UnitModel({
    required this.id,
    required this.name,
    required this.shortName,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      id: map['id'],
      name: map['name'],
      shortName: map['shortName'],
      description: map['description'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}

class AttributeValueModel {
  final String id;
  String name;
  final bool isNew;

  AttributeValueModel({
    required this.id,
    required this.name,
    this.isNew = false,
  });

  factory AttributeValueModel.fromMap(Map<String, dynamic> map) {
    return AttributeValueModel(
      id: map['id'],
      name: map['name'],
      isNew: map['isNew'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isNew': isNew,
    };
  }
}

class AttributeModel {
  final String id;
  final String name;
  final String displayName;
  final List<AttributeValueModel> values;
  final String createdAt;
  final String updatedAt;

  AttributeModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.values,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttributeModel.fromMap(Map<String, dynamic> map) {
    return AttributeModel(
      id: map['id'],
      name: map['name'],
      displayName: map['displayName'],
      values: List<AttributeValueModel>.from(
          map['values']?.map((x) => AttributeValueModel.fromMap(x)) ?? []),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'values': values.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}
