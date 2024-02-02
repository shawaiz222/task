import '../../services/api_service.dart';
import 'item_parameters.dart';

class ItemRepository {
  final ApiService _apiService;

  ItemRepository() : _apiService = ApiService();

  Future<ApiResult> createItem(CreateItemParameters body) async {
    return await _apiService.request("/v1/items",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> updateItem(UpdateItemParameters body, String id) async {
    return await _apiService.request("/v1/items/$id",
        method: HttpMethod.put, data: body.toMap());
  }

  Future<ApiResult> getItems(GetItemsQueryParameters query) async {
    return await _apiService.request("/v1/items",
        method: HttpMethod.get, queryParameters: query.toMap());
  }

  Future<ApiResult> deleteItem(DeleteItemParameters body) async {
    return await _apiService.request("/v1/items",
        method: HttpMethod.delete, data: body.toMap());
  }

  Future<ApiResult> updateItemStock(
      UpdateItemStockParameters body, String itemId, String variationId) async {
    if (variationId.isEmpty) {
      return await _apiService.request("/v1/items/stock/$itemId",
          method: HttpMethod.put, data: body.toMap());
    } else {
      return await _apiService.request(
          "/v1/items/stock/$itemId/variations/$variationId",
          method: HttpMethod.put,
          data: body.toMap());
    }
  }

  Future<ApiResult> createVariation(
      CreateItemVariationParameters body, String itemId) async {
    return await _apiService.request("/v1/items/$itemId/variations",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> updateVariation(UpdateItemVariationParameters body,
      String itemId, String variationId) async {
    return await _apiService.request(
        "/v1/items/$itemId/variations/$variationId",
        method: HttpMethod.put,
        data: body.toMap());
  }

  Future<ApiResult> deleteVariation(String itemId, String variationId) async {
    return await _apiService.request(
        "/v1/items/$itemId/variations/$variationId",
        method: HttpMethod.delete);
  }
}
