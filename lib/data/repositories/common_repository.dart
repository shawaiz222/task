import 'package:dio/dio.dart';

import '../services/api_service.dart';
import 'package:image_picker/image_picker.dart';

class CommonRepository {
  final ApiService _apiService;

  CommonRepository() : _apiService = ApiService();

  Future<ApiResult> uploadImage(XFile image) async {
    var formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path, filename: image.name),
    });
    return await _apiService.request("/v1/upload/image",
        method: HttpMethod.post, data: formData);
  }
}
