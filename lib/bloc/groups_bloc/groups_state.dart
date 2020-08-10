part of 'groups_bloc.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final GroupScreenModel model;
  GroupLoaded({@required this.model});
}

class GroupError extends GroupState {
  final String message;
  GroupError({@required this.message});
}
