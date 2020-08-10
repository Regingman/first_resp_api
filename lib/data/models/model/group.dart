import 'department.dart';

class Group {
  int id;
  String name;
  // ignore: non_constant_identifier_names
  int id_department;
  Department department;

  Group({this.id, this.name});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    id_department = json['id_department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id_department'] = this.id_department;
    return data;
  }
}
