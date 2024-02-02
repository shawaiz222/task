import "../../services/api_service.dart";
import 'customer_parameters.dart';

class CustomerRepository {
  final ApiService _apiService;

  CustomerRepository() : _apiService = ApiService();

  Future<ApiResult> createCustomer(CreateCustomerParameters body) async {
    return await _apiService.request(
      "/v1/customers",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> updateCustomer(
      String id, UpdateCustomerParameters body) async {
    return await _apiService.request(
      "/v1/customers/$id",
      method: HttpMethod.put,
      data: body.toMap(),
    );
  }

  Future<ApiResult> deleteCustomer(DeleteCustomerParameters body) async {
    return await _apiService.request(
      "/v1/customers",
      method: HttpMethod.delete,
      data: body.toMap(),
    );
  }

  Future<ApiResult> getCustomers(GetCustomersQueryParameters query) async {
    return await _apiService.request(
      "/v1/customers",
      method: HttpMethod.get,
      queryParameters: query.toMap(),
    );
  }
}
