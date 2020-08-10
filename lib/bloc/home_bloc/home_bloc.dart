import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository _repository;
  HomeBloc(this._repository);

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHomeScreenData) yield* _fetchToState();
  }

  Stream<HomeState> _fetchToState() async* {
    yield HomeLoading();
    try {
      await _repository.initAll();
      print('object');
      yield HomeLoaded();
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield HomeError(message: message);
    }
  }
}
