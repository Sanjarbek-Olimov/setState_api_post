import 'dart:convert';
import 'package:http/http.dart';
import '../model/employee_model.dart';
import '../model/employee_model.dart';
import 'log_service.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "dummy.restapiexample.com";
  static String SERVER_PRODUCTION = "dummy.restapiexample.com";

  static Map<String, String> getHeaders() {
    Map<String,String> headers = {'Content-Type':'application/json; charset=UTF-8'};
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if(response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response = await post(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    if(response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response = await put(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if(response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response = await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if(response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if(response.statusCode == 429) return "Too many request";
    return null;
  }

  /* Http Apis */
  static String API_LIST = "/api/v1/employees";
  static String API_ONE_ELEMENT = "/api/v1/employee/"; //{id}
  static String API_CREATE = "/api/v1/create";
  static String API_UPDATE = "/api/v1/update/"; //{id}
  static String API_DELETE = "/api/v1/delete/"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      'employee_name': employee.employeeName!,
      'employee_salary': employee.employeeSalary.toString(),
      'employee_age': employee.employeeAge.toString(),
      'profile_image': employee.profileImage!,
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      'id': employee.id.toString(),
      'employee_name': employee.employeeName!,
      'employee_salary': employee.employeeSalary.toString(),
      'employee_age': employee.employeeAge.toString(),
      'profile_image': employee.profileImage!,
    });
    return params;
  }
}