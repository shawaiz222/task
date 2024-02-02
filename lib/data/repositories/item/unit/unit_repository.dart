import '../../../services/api_service.dart';
import 'unit_parameters.dart';

class UnitRepository {
  final ApiService _apiService;

  UnitRepository() : _apiService = ApiService();

  Future<ApiResult> createUnit(CreateUnitParameters body) async {
    return await _apiService.request("/v1/items/units",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> updateUnit(UpdateUnitParameters body, String id) async {
    return await _apiService.request("/v1/items/units/$id",
        method: HttpMethod.put, data: body.toMap());
  }

  Future<ApiResult> getUnits(GetUnitsQueryParameters query) async {
    return await _apiService.request("/v1/items/units",
        method: HttpMethod.get, queryParameters: query.toMap());
  }

  Future<ApiResult> deleteUnit(DeleteUnitParameters body) async {
    return await _apiService.request("/v1/items/units",
        method: HttpMethod.delete, data: body.toMap());
  }
}
