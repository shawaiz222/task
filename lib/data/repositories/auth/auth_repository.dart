import "../../services/api_service.dart";
import 'auth_parameters.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository() : _apiService = ApiService();

  Future<ApiResult> login(LoginParameters body) async {
    return await _apiService.request("/v1/auth/login",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> register(RegisterParameters body) async {
    return await _apiService.request(
      "/v1/auth/signup",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> sendVerificationEmail(
      SendVerificationEmailParameters body) async {
    return await _apiService.request(
      "/v1/auth/send-verification-email",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> verifyEmail(VerifyEmailParameters body) async {
    return await _apiService.request(
      "/v1/auth/verify-email",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> authenticate() async {
    return await _apiService.request(
      "/v1/auth/me",
      method: HttpMethod.get,
    );
  }

  Future<void> logout() async {
    await _apiService.request(
      "/v1/auth/logout",
      method: HttpMethod.post,
    );
    final box = GetStorage();
    box.remove('token');
    box.remove('user');
    Get.offAllNamed('/login');
  }

  Future<ApiResult> forgotPassword(ForgotPasswordParameters body) async {
    return await _apiService.request(
      "/v1/auth/forgot-password",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> resetPassword(ResetPasswordParameters body) async {
    return await _apiService.request(
      "/v1/auth/reset-password",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> addCompany(AddCompanyParameters body) async {
    return await _apiService.request(
      "/v1/auth/add-company",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }
}
