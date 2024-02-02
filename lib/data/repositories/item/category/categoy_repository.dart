import '../../../services/api_service.dart';
import 'category_parameters.dart';

class CategoryRepository {
  final ApiService _apiService;

  CategoryRepository() : _apiService = ApiService();

  Future<ApiResult> createCategory(CreateCategoryParameters body) async {
    return await _apiService.request("/v1/items/categories",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> updateCategory(
      UpdateCategoryParameters body, String id) async {
    return await _apiService.request("/v1/items/categories/$id",
        method: HttpMethod.put, data: body.toMap());
  }

  Future<ApiResult> getCategories(GetCategoriesQueryParameters query) async {
    return await _apiService.request("/v1/items/categories",
        method: HttpMethod.get, queryParameters: query.toMap());
  }

  Future<ApiResult> deleteCategory(DeleteCategoryParameters body) async {
    return await _apiService.request("/v1/items/categories",
        method: HttpMethod.delete, data: body.toMap());
  }
}
