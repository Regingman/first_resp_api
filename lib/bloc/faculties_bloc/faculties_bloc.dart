import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/model/faculty.dart';
import 'package:first_resp_api/data/models/screen_model/faculty_screen_model.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'faculties_event.dart';
part 'faculties_state.dart';

class FacultyBloc extends Bloc<FacultyEvent, FacultyState> {
  Repository _repository;
  FacultyBloc(this._repository);

  @override
  FacultyState get initialState => FacultyInitial();

  @override
  Stream<FacultyState> mapEventToState(
    FacultyEvent event,
  ) async* {
    if (event is FetchFacultyScreenData) yield* _fetchToState();
    if (event is CreateFacultyEvent) yield* _createFaculty(event);
    if (event is UpdateFacultyEvent) yield* _updateFaculty(event);
    if (event is DeleteFacultyEvent) yield* _deleteFaculty(event);
  }

  Stream<FacultyState> _deleteFaculty(DeleteFacultyEvent event) async* {
    yield FacultyLoading();
    try {
      _repository.facultyProvider.deleteFaculty(event.faculty);
      int index = _repository.faculies
          .indexWhere((Faculty faculty) => faculty.id == event.faculty.id);
      _repository.faculies.removeAt(index);
      var model = new FacultyScreenModel(_repository.faculies);
      yield FacultyLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;
      yield FacultyError(message: message);
    }
  }

  Stream<FacultyState> _createFaculty(CreateFacultyEvent event) async* {
    yield FacultyLoading();
    try {
      Faculty faculty =
          await _repository.facultyProvider.createFaculty(event.faculty.name);
      _repository.faculies.add(faculty);
      var model = new FacultyScreenModel(_repository.faculies);
      yield FacultyLoaded(model: model);
    } catch (e) {
      print(e.message);
      String message = e.message;
      if (e is SocketException) message = e.message;
      yield FacultyError(message: message);
    }
  }

  Stream<FacultyState> _updateFaculty(UpdateFacultyEvent event) async* {
    yield FacultyLoading();
    try {
      _repository.facultyProvider.updateFaculty(event.faculty);
      int index = _repository.faculies
          .indexWhere((Faculty faculty) => faculty.id == event.faculty.id);
      _repository.faculies[index] = event.faculty;
      var model = new FacultyScreenModel(_repository.faculies);
      yield FacultyLoaded(model: model);
    } catch (e) {
      print(e.message);
      String message = e.message;
      if (e is SocketException) message = e.message;
      yield FacultyError(message: message);
    }
  }

  Stream<FacultyState> _fetchToState() async* {
    yield FacultyLoading();
    try {
      print('object');
      var model = new FacultyScreenModel(_repository.faculies);
      yield FacultyLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield FacultyError(message: message);
    }
  }
}
