part of 'teachers_bloc.dart';

@immutable
abstract class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoaded extends TeacherState {
  final TeacherScreenModel model;
  TeacherLoaded({@required this.model});
}

class TeacherError extends TeacherState {
  final String message;
  TeacherError({@required this.message});
}
