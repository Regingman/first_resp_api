import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/screen_model/department_screen_model.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'departments_event.dart';
part 'departments_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  Repository _repository;
  DepartmentBloc(this._repository);

  @override
  DepartmentState get initialState => DepartmentInitial();

  @override
  Stream<DepartmentState> mapEventToState(
    DepartmentEvent event,
  ) async* {
    if (event is FetchDepartmentScreenData) yield* _fetchToState();
  }

  Stream<DepartmentState> _fetchToState() async* {
    yield DepartmentLoading();
    try {
      print('object');
      var model = new DepartmentScreenModel(_repository.departments);
      yield DepartmentLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield DepartmentError(message: message);
    }
  }
}
