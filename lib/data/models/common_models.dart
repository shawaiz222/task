import 'dart:convert';

class ImageModel {
  final String? key;

  ImageModel({
    this.key,
  });

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      key: map['key'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
    };
  }

  String toJson() => json.encode(toMap());
}
