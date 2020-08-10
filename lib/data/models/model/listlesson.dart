class ListLesson {
  int id;
  int numberLesson;
  int dayOfWeek;
  // ignore: non_constant_identifier_names
  int id_group;
  // ignore: non_constant_identifier_names
  int id_teacher;
  // ignore: non_constant_identifier_names
  int id_lesson;

  ListLesson(
      {this.id,
      this.dayOfWeek,
      // ignore: non_constant_identifier_names
      this.id_group,
      // ignore: non_constant_identifier_names
      this.id_lesson,
      // ignore: non_constant_identifier_names
      this.id_teacher,
      this.numberLesson});

  ListLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numberLesson = json['numberLesson'];
    dayOfWeek = json['dayOfWeek'];
    id_group = json['id_group'];
    id_teacher = json['id_teacher'];
    id_lesson = json['id_lesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['numberLesson'] = this.numberLesson;
    data['dayOfWeek'] = this.dayOfWeek;
    data['id_group'] = this.id_group;
    data['id_teacher'] = this.id_lesson;
    data['id_lesson'] = this.id_teacher;
    return data;
  }
}
