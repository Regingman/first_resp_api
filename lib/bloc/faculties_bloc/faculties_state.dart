part of 'faculties_bloc.dart';

@immutable
abstract class FacultyState {}

class FacultyInitial extends FacultyState {}

class FacultyLoading extends FacultyState {}

class FacultyLoaded extends FacultyState {
  final FacultyScreenModel model;
  FacultyLoaded({@required this.model});
}

class FacultyError extends FacultyState {
  final String message;
  FacultyError({@required this.message});
}
