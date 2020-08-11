part of 'faculties_bloc.dart';

@immutable
abstract class FacultyEvent {}

class FetchFacultyScreenData extends FacultyEvent {}

class DeleteFacultyEvent extends FacultyEvent {
  final Faculty faculty;
  DeleteFacultyEvent(this.faculty);
}

class UpdateFacultyEvent extends FacultyEvent {
  final Faculty faculty;
  UpdateFacultyEvent(this.faculty);
}

class CreateFacultyEvent extends FacultyEvent {
  final Faculty faculty;
  CreateFacultyEvent(this.faculty);
}
