import 'dart:convert' as convert;
import 'package:first_resp_api/data/models/model/group.dart';
import 'package:first_resp_api/data/providers/services/api_service.dart';
import 'package:http/http.dart' as http;

class GroupProvider {
  Future<List<Group>> getAll() async {
    List<Group> groups = [];
    var groupsResponse = await http.get(ApiService.groups);
    var jsonResponse = convert.jsonDecode(groupsResponse.body);
    for (var json in jsonResponse) {
      groups.add(Group.fromJson(json));
    }
    return groups;
  }

  Future<Group> createGroup(int groupId, String name) async {
    Map map = {"id_group": groupId, "name": name};
    var groupsResponse = await http.post(ApiService.groups,
        headers: {"Content-Type": "application/json"}, body: map);
    if (groupsResponse.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(groupsResponse.body);
      var group = Group.fromJson(jsonResponse);
      return group;
    } else
      return null;
  }

  Future<bool> updateGroup(Group group) async {
    Map map = group.toJson();
    var groupsResponse = await http.put("${ApiService.groups}/${group.id}",
        headers: {"Content-Type": "application/json"}, body: map);
    if (groupsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteGroup(Group group) async {
    var groupsResponse =
        await http.delete("${ApiService.faculties}/${group.id}");
    if (groupsResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
