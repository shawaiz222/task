import '../../../services/api_service.dart';
import 'attribute_parameters.dart';

class AttributeRepository {
  final ApiService _apiService;

  AttributeRepository() : _apiService = ApiService();

  Future<ApiResult> createAttribute(CreateAttributeParameters body) async {
    return await _apiService.request("/v1/items/attributes",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> updateAttribute(
      UpdateAttributeParameters body, String id) async {
    return await _apiService.request("/v1/items/attributes/$id",
        method: HttpMethod.put, data: body.toMap());
  }

  Future<ApiResult> getAttributes(GetAttributesQueryParameters query) async {
    return await _apiService.request("/v1/items/attributes",
        method: HttpMethod.get, queryParameters: query.toMap());
  }

  Future<ApiResult> deleteAttribute(DeleteAttributeParameters body) async {
    return await _apiService.request("/v1/items/attributes",
        method: HttpMethod.delete, data: body.toMap());
  }
}
