part of 'departments_bloc.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class DepartmentLoading extends DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  final DepartmentScreenModel model;
  DepartmentLoaded({@required this.model});
}

class DepartmentError extends DepartmentState {
  final String message;
  DepartmentError({@required this.message});
}
