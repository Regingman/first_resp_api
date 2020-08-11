import 'package:first_resp_api/data/models/model/department.dart';
import 'package:first_resp_api/data/models/model/faculty.dart';

class DepartmentScreenModel {
  final List<Department> departments;
  final List<Faculty> faculties;

  DepartmentScreenModel(this.departments, this.faculties);
}
