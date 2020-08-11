import 'dart:convert' as convert;
import 'dart:convert';
import 'package:first_resp_api/data/models/model/department.dart';
import 'package:first_resp_api/data/providers/services/api_service.dart';
import 'package:http/http.dart' as http;

class DepartmentProvider {
  Future<List<Department>> getAll() async {
    List<Department> departments = new List<Department>();
    var departmentsResponse = await http.get(ApiService.departments);
    var jsonResponse = convert.jsonDecode(departmentsResponse.body);
    for (var json in jsonResponse) {
      departments.add(Department.fromJson(json));
    }
    return departments;
  }

  Future<Department> createDepartment(int facultyId, String name) async {
    Map map = {"id_faculty": facultyId, "name": name};
    String json = jsonEncode(map);
    Map<String, String> headers = {"Content-type": "application/json"};
    var departmentsResponse =
        await http.post(ApiService.departments, headers: headers, body: json);
    if (departmentsResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(departmentsResponse.body);
      var department = Department.fromJson(jsonResponse);
      return department;
    } else
      return null;
  }

  Future<bool> updateDepartment(Department department) async {
    String json = jsonEncode(department);
    Map<String, String> headers = {"Content-type": "application/json"};
    var departmentsResponse = await http.put(
        "${ApiService.departments}${department.id}",
        headers: headers,
        body: json);
    if (departmentsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteDepartment(Department department) async {
    var departmentsResponse =
        await http.delete("${ApiService.departments}${department.id}");
    if (departmentsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
