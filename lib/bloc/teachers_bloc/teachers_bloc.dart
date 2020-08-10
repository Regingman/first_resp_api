import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/screen_model/techear_screen_model.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'teachers_event.dart';
part 'teachers_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  Repository _repository;
  TeacherBloc(this._repository);

  @override
  TeacherState get initialState => TeacherInitial();

  @override
  Stream<TeacherState> mapEventToState(
    TeacherEvent event,
  ) async* {
    if (event is FetchTeacherScreenData) yield* _fetchToState();
  }

  Stream<TeacherState> _fetchToState() async* {
    yield TeacherLoading();
    try {
      print('object');
      var model = new TeacherScreenModel(_repository.teachers);
      yield TeacherLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield TeacherError(message: message);
    }
  }
}
