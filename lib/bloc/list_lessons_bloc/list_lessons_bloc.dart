import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/screen_model/list_lesson_screen_model.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_lessons_event.dart';
part 'list_lessons_state.dart';

class ListLessonssBloc extends Bloc<ListLessonEvent, ListLessonState> {
  Repository _repository;
  ListLessonssBloc(this._repository);

  @override
  ListLessonState get initialState => ListLessonInitial();

  @override
  Stream<ListLessonState> mapEventToState(
    ListLessonEvent event,
  ) async* {
    if (event is FetchListLessonScreenData) yield* _fetchToState();
  }

  Stream<ListLessonState> _fetchToState() async* {
    yield ListLessonLoading();
    try {
      print('object');
      var model = new ListLessonScreenModel(_repository.listLessons);
      yield ListLessonLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield ListLessonError(message: message);
    }
  }
}
