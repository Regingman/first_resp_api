import 'dart:convert' as convert;
import 'dart:convert';
import 'package:first_resp_api/data/models/model/faculty.dart';
import 'package:first_resp_api/data/providers/services/api_service.dart';
import 'package:http/http.dart' as http;

class FacultyProvider {
  Future<List<Faculty>> getAll() async {
    List<Faculty> faculties = [];
    var facultiesResponse = await http.get(ApiService.faculties);
    var jsonResponse = convert.jsonDecode(facultiesResponse.body);
    for (var json in jsonResponse) {
      faculties.add(Faculty.fromJson(json));
    }
    return faculties;
  }

  Future<Faculty> createFaculty(String name) async {
    Map map = {"name": name};
    String json = jsonEncode(map);
    Map<String, String> headers = {"Content-type": "application/json"};
    var facultysResponse =
        await http.post(ApiService.faculties, headers: headers, body: json);
    if (facultysResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(facultysResponse.body);
      var faculty = Faculty.fromJson(jsonResponse);
      return faculty;
    } else
      return null;
  }

  Future<bool> updateFaculty(Faculty faculty) async {
    Map map = faculty.toJson();
    String json = jsonEncode(faculty);
    Map<String, String> headers = {"Content-type": "application/json"};
    var facultysResponse = await http.put(
        "${ApiService.faculties}/${faculty.id}",
        headers: headers,
        body: json);
    if (facultysResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFaculty(Faculty faculty) async {
    var facultysResponse =
        await http.delete("${ApiService.faculties}${faculty.id}");
    if (facultysResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
