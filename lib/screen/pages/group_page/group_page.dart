import 'package:first_resp_api/bloc/groups_bloc/groups_bloc.dart';
import 'package:first_resp_api/data/models/model/group.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupPage extends StatefulWidget {
  static String route = 'home';
  GroupPage({Key key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupsBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupLoaded) _listenLoaded();
      },
      child: BlocBuilder<GroupsBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupInitial) _listenInitial(context);
          if (state is GroupLoaded) return _buildLoaded(state);
          if (state is GroupError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<GroupsBloc>().add(FetchGroupScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(GroupLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
      ),
      body: ListView.builder(
        itemCount: state.model.groups.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.groups[index];
          return _buildListItem(itemTask);
        },
      ),
    );
  }

  Widget _buildListItem(Group state) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {},
        )
      ],
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('${state.id}'),
            foregroundColor: Colors.white,
          ),
          title: Text(state.name),
        ),
      ),
    );
  }
}

class GroupBloc {}
