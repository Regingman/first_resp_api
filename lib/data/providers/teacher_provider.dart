import 'dart:convert' as convert;
import 'package:first_resp_api/data/models/model/teacher.dart';
import 'package:first_resp_api/data/providers/services/api_service.dart';
import 'package:http/http.dart' as http;

class TeacherProvider {
  Future<List<Teacher>> getAll() async {
    List<Teacher> teachers = [];
    var teachersResponse = await http.get(ApiService.teachers);
    var jsonResponse = convert.jsonDecode(teachersResponse.body);
    for (var json in jsonResponse) {
      teachers.add(Teacher.fromJson(json));
    }
    return teachers;
  }

  Future<Teacher> createTeacher(int teacherId, String name) async {
    Map map = {"id_teacher": teacherId, "name": name};
    var teachersResponse = await http.post(ApiService.teachers,
        headers: {"Content-Type": "application/json"}, body: map);
    if (teachersResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(teachersResponse.body);
      var teacher = Teacher.fromJson(jsonResponse);
      return teacher;
    } else
      return null;
  }

  Future<bool> updateTeacher(Teacher teacher) async {
    Map map = teacher.toJson();
    var teachersResponse = await http.put(
        "${ApiService.teachers}/${teacher.id}",
        headers: {"Content-Type": "application/json"},
        body: map);
    if (teachersResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTeacher(Teacher teacher) async {
    var teachersResponse =
        await http.delete("${ApiService.faculties}/${teacher.id}");
    if (teachersResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
