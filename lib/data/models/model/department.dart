class Department {
  int id;
  String name;
  // ignore: non_constant_identifier_names
  int id_faculty;

  Department({this.id, this.name});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    id_faculty = json['id_faculty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id_faculty'] = this.id_faculty;
    return data;
  }
}
