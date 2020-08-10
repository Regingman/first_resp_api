import 'package:first_resp_api/data/models/model/department.dart';
import 'package:first_resp_api/data/models/model/faculty.dart';
import 'package:first_resp_api/data/models/model/group.dart';
import 'package:first_resp_api/data/models/model/lesson.dart';
import 'package:first_resp_api/data/models/model/listlesson.dart';
import 'package:first_resp_api/data/models/model/teacher.dart';
import 'package:first_resp_api/data/providers/department_provider.dart';
import 'package:first_resp_api/data/providers/faculty_provider.dart';
import 'package:first_resp_api/data/providers/groups_provider.dart';
import 'package:first_resp_api/data/providers/lesson_provider.dart';
import 'package:first_resp_api/data/providers/list_lessons_provider.dart';
import 'package:first_resp_api/data/providers/teacher_provider.dart';

class Repository {
  DepartmentProvider _departmentProvider = new DepartmentProvider();
  FacultyProvider _facultyProvider = new FacultyProvider();
  GroupProvider _groupProvider = new GroupProvider();
  LessonProvider _lessonProvider = new LessonProvider();
  ListLessonProvider _listLessonProvider = new ListLessonProvider();
  TeacherProvider _teacherProvider = new TeacherProvider();

  List<Department> departments = [];
  List<Faculty> faculies = [];
  List<Group> groups = [];
  List<Lesson> lessons = [];
  List<ListLesson> listLessons = [];
  List<Teacher> teachers = [];

  Future<bool> initAll() async {
    this.faculies = await _facultyProvider.getAll();
    this.departments = await _departmentProvider.getAll();
    this.groups = await _groupProvider.getAll();
    this.lessons = await _lessonProvider.getAll();
    this.listLessons = await _listLessonProvider.getAll();
    this.teachers = await _teacherProvider.getAll();

    return true;
  }
}
