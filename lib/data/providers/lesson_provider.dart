import 'dart:convert' as convert;
import 'package:first_resp_api/data/models/model/lesson.dart';
import 'package:first_resp_api/data/providers/services/api_service.dart';
import 'package:http/http.dart' as http;

class LessonProvider {
  Future<List<Lesson>> getAll() async {
    List<Lesson> lessons = [];
    var lessonsResponse = await http.get(ApiService.lessons);
    var jsonResponse = convert.jsonDecode(lessonsResponse.body);
    for (var json in jsonResponse) {
      lessons.add(Lesson.fromJson(json));
    }
    return lessons;
  }

  Future<Lesson> createLesson(int lessonId, String name) async {
    Map map = {"id_lesson": lessonId, "name": name};
    var lessonsResponse = await http.post(ApiService.lessons,
        headers: {"Content-Type": "application/json"}, body: map);
    if (lessonsResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(lessonsResponse.body);
      var lesson = Lesson.fromJson(jsonResponse);
      return lesson;
    } else
      return null;
  }

  Future<bool> updateLesson(Lesson lesson) async {
    Map map = lesson.toJson();
    var lessonsResponse = await http.put("${ApiService.lessons}/${lesson.id}",
        headers: {"Content-Type": "application/json"}, body: map);
    if (lessonsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteLesson(Lesson lesson) async {
    var lessonsResponse =
        await http.delete("${ApiService.faculties}/${lesson.id}");
    if (lessonsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
