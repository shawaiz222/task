import "../../services/api_service.dart";
import 'members_parameters.dart';

class MemberRepository {
  final ApiService _apiService;

  MemberRepository() : _apiService = ApiService();

  Future<ApiResult> createMember(CreateMemberParameters body) async {
    return await _apiService.request(
      "/v1/auth/members",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> updateMember(String id, UpdateMemberParameters body) async {
    return await _apiService.request(
      "/v1/auth/members/$id",
      method: HttpMethod.put,
      data: body.toMap(),
    );
  }

  Future<ApiResult> deleteMember(DeleteMemberParameters body) async {
    return await _apiService.request(
      "/v1/auth/members",
      method: HttpMethod.delete,
      data: body.toMap(),
    );
  }

  Future<ApiResult> getMembers(GetMembersQueryParameters query) async {
    return await _apiService.request(
      "/v1/auth/members",
      method: HttpMethod.get,
      queryParameters: query.toMap(),
    );
  }

  Future<ApiResult> getRolesOptions() async {
    return await _apiService.request(
      "/v1/auth/roles/options",
      method: HttpMethod.get,
    );
  }
}
