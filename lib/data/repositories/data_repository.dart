import '../services/api_service.dart';

class DataRepository {
  final ApiService _apiService;

  DataRepository() : _apiService = ApiService();

  Future<ApiResult> getData(String type) async {
    return await _apiService.request("/v1/data/$type", method: HttpMethod.get);
  }

  Future<ApiResult> categoriesOptions() async {
    return await _apiService.request("/v1/items/categories/options",
        method: HttpMethod.get);
  }

  Future<ApiResult> unitsOptions() async {
    return await _apiService.request("/v1/items/units/options",
        method: HttpMethod.get);
  }

  Future<ApiResult> attributesOptions() async {
    return await _apiService.request("/v1/items/attributes/options",
        method: HttpMethod.get);
  }
}
