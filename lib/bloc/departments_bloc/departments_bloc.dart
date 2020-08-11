import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/model/department.dart';
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
    if (event is CreateDepartmentEvent) yield* _createDepartment(event);
    if (event is UpdateDepartmentEvent) yield* _updateDepartment(event);
    if (event is DeleteDepartmetnEvent) yield* _deleteDepartment(event);
  }

  Stream<DepartmentState> _deleteDepartment(
      DeleteDepartmetnEvent event) async* {
    yield DepartmentLoading();
    try {
      _repository.departmentProvider.deleteDepartment(event.department);
      int index = _repository.departments.indexWhere(
          (Department department) => department.id == event.department.id);
      _repository.departments.removeAt(index);
      var model = new DepartmentScreenModel(
          _repository.departments, _repository.faculies);
      yield DepartmentLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;
      yield DepartmentError(message: message);
    }
  }

  Stream<DepartmentState> _createDepartment(
      CreateDepartmentEvent event) async* {
    yield DepartmentLoading();
    try {
      Department deparment = await _repository.departmentProvider
          .createDepartment(event.department.id_faculty, event.department.name);
      _repository.departments.add(deparment);
      var model = new DepartmentScreenModel(
          _repository.departments, _repository.faculies);
      yield DepartmentLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;
      yield DepartmentError(message: message);
    }
  }

  Stream<DepartmentState> _updateDepartment(
      UpdateDepartmentEvent event) async* {
    yield DepartmentLoading();
    try {
      _repository.departmentProvider.updateDepartment(event.department);
      int index = _repository.departments.indexWhere(
          (Department department) => department.id == event.department.id);
      _repository.departments[index] = event.department;
      var model = new DepartmentScreenModel(
          _repository.departments, _repository.faculies);
      yield DepartmentLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;
      yield DepartmentError(message: message);
    }
  }

  Stream<DepartmentState> _fetchToState() async* {
    yield DepartmentLoading();
    try {
      print('object');
      var model = new DepartmentScreenModel(
          _repository.departments, _repository.faculies);
      yield DepartmentLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield DepartmentError(message: message);
    }
  }
}
