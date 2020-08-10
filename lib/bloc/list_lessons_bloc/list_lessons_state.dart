part of 'list_lessons_bloc.dart';

@immutable
abstract class ListLessonState {}

class ListLessonInitial extends ListLessonState {}

class ListLessonLoading extends ListLessonState {}

class ListLessonLoaded extends ListLessonState {
  final ListLessonScreenModel model;
  ListLessonLoaded({@required this.model});
}

class ListLessonError extends ListLessonState {
  final String message;
  ListLessonError({@required this.message});
}
