part of 'departments_bloc.dart';

@immutable
abstract class DepartmentEvent {}

class FetchDepartmentScreenData extends DepartmentEvent {}

class DeleteDepartmetnEvent extends DepartmentEvent {
  final Department department;
  DeleteDepartmetnEvent(this.department);
}

class UpdateDepartmentEvent extends DepartmentEvent {
  final Department department;
  UpdateDepartmentEvent(this.department);
}

class CreateDepartmentEvent extends DepartmentEvent {
  final Department department;
  CreateDepartmentEvent(this.department);
}
