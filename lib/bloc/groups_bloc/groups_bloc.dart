import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:first_resp_api/data/models/screen_model/group_screen_model.dart';
import 'package:first_resp_api/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupEvent, GroupState> {
  Repository _repository;
  GroupsBloc(this._repository);

  @override
  GroupState get initialState => GroupInitial();

  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    if (event is FetchGroupScreenData) yield* _fetchToState();
  }

  Stream<GroupState> _fetchToState() async* {
    yield GroupLoading();
    try {
      print('object');
      var model = new GroupScreenModel(_repository.groups);
      yield GroupLoaded(model: model);
    } catch (e) {
      String message;
      if (e is SocketException) message = e.message;

      print('object');
      yield GroupError(message: message);
    }
  }
}
