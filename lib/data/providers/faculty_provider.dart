import 'dart:convert' as convert;
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

  Future<Faculty> createFaculty(int facultyId, String name) async {
    Map map = {"id_faculty": facultyId, "name": name};
    var facultysResponse = await http.post(ApiService.faculties,
        headers: {"Content-Type": "application/json"}, body: map);
    if (facultysResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(facultysResponse.body);
      var faculty = Faculty.fromJson(jsonResponse);
      return faculty;
    } else
      return null;
  }

  Future<bool> updateFaculty(Faculty faculty) async {
    Map map = faculty.toJson();
    var facultysResponse = await http.put(
        "${ApiService.faculties}/${faculty.id}",
        headers: {"Content-Type": "application/json"},
        body: map);
    if (facultysResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFaculty(Faculty faculty) async {
    var facultysResponse =
        await http.delete("${ApiService.faculties}/${faculty.id}");
    if (facultysResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
