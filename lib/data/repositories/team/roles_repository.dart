import "../../services/api_service.dart";
import 'roles_parameters.dart';

class RoleRepository {
  final ApiService _apiService;

  RoleRepository() : _apiService = ApiService();

  Future<ApiResult> createRole(CreateRoleParameters body) async {
    return await _apiService.request(
      "/v1/auth/roles",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> updateRole(String id, UpdateRoleParameters body) async {
    return await _apiService.request(
      "/v1/auth/roles/$id",
      method: HttpMethod.put,
      data: body.toMap(),
    );
  }

  Future<ApiResult> deleteRole(DeleteRoleParameters body) async {
    return await _apiService.request(
      "/v1/auth/roles",
      method: HttpMethod.delete,
      data: body.toMap(),
    );
  }

  Future<ApiResult> getRoles(GetRolesQueryParameters query) async {
    return await _apiService.request(
      "/v1/auth/roles",
      method: HttpMethod.get,
      queryParameters: query.toMap(),
    );
  }
}
