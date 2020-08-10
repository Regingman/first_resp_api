part of 'lessons_bloc.dart';

@immutable
abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonLoaded extends LessonState {
  final LessonScreenModel model;
  LessonLoaded({@required this.model});
}

class LessonError extends LessonState {
  final String message;
  LessonError({@required this.message});
}
