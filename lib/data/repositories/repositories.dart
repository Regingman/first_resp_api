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
  DepartmentProvider departmentProvider = new DepartmentProvider();
  FacultyProvider facultyProvider = new FacultyProvider();
  GroupProvider groupProvider = new GroupProvider();
  LessonProvider lessonProvider = new LessonProvider();
  ListLessonProvider listLessonProvider = new ListLessonProvider();
  TeacherProvider teacherProvider = new TeacherProvider();

  List<Department> departments = [];
  List<Faculty> faculies = [];
  List<Group> groups = [];
  List<Lesson> lessons = [];
  List<ListLesson> listLessons = [];
  List<Teacher> teachers = [];

  Future<bool> initAll() async {
    this.faculies = await facultyProvider.getAll();
    this.departments = await departmentProvider.getAll();
    this.groups = await groupProvider.getAll();
    this.lessons = await lessonProvider.getAll();
    this.listLessons = await listLessonProvider.getAll();
    this.teachers = await teacherProvider.getAll();

    return true;
  }
}
