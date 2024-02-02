import "../../services/api_service.dart";
import 'expense_parameters.dart';

class ExpenseRepository {
  final ApiService _apiService;

  ExpenseRepository() : _apiService = ApiService();

  Future<ApiResult> createExpenseType(CreateExpenseTypeParameters body) async {
    return await _apiService.request("/v1/expenses/types",
        method: HttpMethod.post, data: body.toMap());
  }

  Future<ApiResult> createExpense(CreateExpenseParameters body) async {
    return await _apiService.request(
      "/v1/expenses",
      method: HttpMethod.post,
      data: body.toMap(),
    );
  }

  Future<ApiResult> getExpenseTypes() async {
    return await _apiService.request(
      "/v1/expenses/types",
      method: HttpMethod.get,
    );
  }

  Future<ApiResult> updateExpense(
      String id, UpdateExpenseParameters body) async {
    return await _apiService.request(
      "/v1/expenses/$id",
      method: HttpMethod.put,
      data: body.toMap(),
    );
  }

  Future<ApiResult> deleteExpense(DeleteExpenseParameters body) async {
    return await _apiService.request(
      "/v1/expenses",
      method: HttpMethod.delete,
      data: body.toMap(),
    );
  }

  Future<ApiResult> getExpenses(GetExpensesQueryParameters query) async {
    return await _apiService.request(
      "/v1/expenses",
      method: HttpMethod.get,
      queryParameters: query.toMap(),
    );
  }
}
