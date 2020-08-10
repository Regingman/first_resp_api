import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/screen_model/lesson_screen_model.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonssBloc extends Bloc<LessonEvent, LessonState> {
  Repository _repository;
  LessonssBloc(this._repository);

  @override
  LessonState get initialState => LessonInitial();

  @override
  Stream<LessonState> mapEventToState(
    LessonEvent event,
  ) async* {
    if (event is FetchLessonScreenData) yield* _fetchToState();
  }

  Stream<LessonState> _fetchToState() async* {
    yield LessonLoading();
    try {
      print('object');
      var model = new LessonScreenModel(_repository.lessons);
      yield LessonLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield LessonError(message: message);
    }
  }
}
