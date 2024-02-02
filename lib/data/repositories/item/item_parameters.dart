import 'package:invoder_app/data/models/common_models.dart';

class CreateItemParameters {
  final String itemType;
  final String type;

  CreateItemParameters({
    required this.itemType,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemType': itemType,
      'type': type,
    };
  }
}

class UpdateItemParameters {
  final ImageModel? image;
  final String? type;
  final String? name;
  final String? category;
  final String? unit;
  final String? description;
  final double? price;
  final String? sku;
  final String? barcode;
  final List<String>? attributes;
  final bool? nonTaxable;

  UpdateItemParameters({
    this.image,
    this.type,
    this.name,
    this.category,
    this.unit,
    this.description,
    this.price,
    this.sku,
    this.barcode,
    this.attributes,
    this.nonTaxable,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image?.toMap(),
      'type': type,
      'name': name,
      'category': category,
      'unit': unit,
      'description': description,
      'price': price,
      'sku': sku,
      'barcode': barcode,
      'attributes': attributes,
      'nonTaxable': nonTaxable,
    };
  }
}

class DeleteItemParameters {
  final List<String> ids;

  DeleteItemParameters({
    required this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'ids': ids,
    };
  }
}

class GetItemsQueryParameters {
  final String itemType;
  final String? type;
  final String? search;
  final int? page;
  final int? limit;

  GetItemsQueryParameters({
    required this.itemType,
    this.type,
    this.search,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemType': itemType,
      'type': type,
      'search': search,
      'page': page,
      'limit': limit,
    };
  }
}

class UpdateItemStockParameters {
  final String? reason;
  final double? value;

  UpdateItemStockParameters({
    this.reason,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'reason': reason,
      'value': value,
    };
  }
}

class CreateItemVariationParameters {
  final String? name;
  final List<Map<String, dynamic>>? variables;
  final String? sku;
  final String? barcode;
  final double? price;

  CreateItemVariationParameters({
    this.name,
    this.variables,
    this.sku,
    this.barcode,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'variables': variables,
      'sku': sku,
      'barcode': barcode,
      'price': price,
    };
  }
}

class UpdateItemVariationParameters {
  final String? name;
  final String? sku;
  final ImageModel? image;
  final String? barcode;
  final double? price;

  UpdateItemVariationParameters({
    this.name,
    this.sku,
    this.image,
    this.barcode,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sku': sku,
      'image': image?.toMap(),
      'barcode': barcode,
      'price': price,
    };
  }
}
