import 'package:first_resp_api/bloc/teachers_bloc/teachers_bloc.dart';
import 'package:first_resp_api/data/models/model/teacher.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TeacherPage extends StatefulWidget {
  static String route = 'home';
  TeacherPage({Key key}) : super(key: key);

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherBloc, TeacherState>(
      listener: (context, state) {
        if (state is TeacherLoaded) _listenLoaded();
      },
      child: BlocBuilder<TeacherBloc, TeacherState>(
        builder: (context, state) {
          if (state is TeacherInitial) _listenInitial(context);
          if (state is TeacherLoaded) return _buildLoaded(state);
          if (state is TeacherError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<TeacherBloc>().add(FetchTeacherScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(TeacherLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher"),
      ),
      body: ListView.builder(
        itemCount: state.model.teachers.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.teachers[index];
          return _buildListItem(itemTask);
        },
      ),
    );
  }

  Widget _buildListItem(Teacher state) {
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
