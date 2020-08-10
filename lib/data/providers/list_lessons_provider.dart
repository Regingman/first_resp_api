import 'dart:convert' as convert;
import 'package:first_resp_api/data/models/model/listlesson.dart';
import 'package:first_resp_api/data/providers/services/api_service.dart';
import 'package:http/http.dart' as http;

class ListLessonProvider {
  Future<List<ListLesson>> getAll() async {
    List<ListLesson> listLessons = [];
    var listLessonsResponse = await http.get(ApiService.listLessons);
    var jsonResponse = convert.jsonDecode(listLessonsResponse.body);
    for (var json in jsonResponse) {
      listLessons.add(ListLesson.fromJson(json));
    }
    return listLessons;
  }

  Future<ListLesson> createListListLesson(int listLessonId, String name) async {
    Map map = {"id_lesson": listLessonId, "name": name};
    var lessonsResponse = await http.post(ApiService.listLessons,
        headers: {"Content-Type": "application/json"}, body: map);
    if (lessonsResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(lessonsResponse.body);
      var lesson = ListLesson.fromJson(jsonResponse);
      return lesson;
    } else
      return null;
  }

  Future<bool> updateListLesson(ListLesson listLesson) async {
    Map map = listLesson.toJson();
    var lessonsResponse = await http.put(
        "${ApiService.lessons}/${listLesson.id}",
        headers: {"Content-Type": "application/json"},
        body: map);
    if (lessonsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteListLesson(ListLesson listLesson) async {
    var lessonsResponse =
        await http.delete("${ApiService.faculties}/${listLesson.id}");
    if (lessonsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
