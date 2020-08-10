import 'package:first_resp_api/bloc/list_lessons_bloc/list_lessons_bloc.dart';
import 'package:first_resp_api/data/models/model/listlesson.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListLessonPage extends StatefulWidget {
  static String route = 'home';
  ListLessonPage({Key key}) : super(key: key);

  @override
  _ListLessonPageState createState() => _ListLessonPageState();
}

class _ListLessonPageState extends State<ListLessonPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ListLessonssBloc, ListLessonState>(
      listener: (context, state) {
        if (state is ListLessonLoaded) _listenLoaded();
      },
      child: BlocBuilder<ListLessonssBloc, ListLessonState>(
        builder: (context, state) {
          if (state is ListLessonInitial) _listenInitial(context);
          if (state is ListLessonLoaded) return _buildLoaded(state);
          if (state is ListLessonError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<ListLessonssBloc>().add(FetchListLessonScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(ListLessonLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListLessons"),
      ),
      body: ListView.builder(
        itemCount: state.model.listLessons.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.listLessons[index];
          return _buildListItem(itemTask);
        },
      ),
    );
  }

  Widget _buildListItem(ListLesson state) {
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
          title: Text(state.numberLesson.toString()),
        ),
      ),
    );
  }
}

class ListLessonsBloc {}

class ListLessonBloc {}
