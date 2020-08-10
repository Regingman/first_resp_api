import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
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
