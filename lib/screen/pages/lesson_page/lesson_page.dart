import 'package:first_resp_api/bloc/lessons_bloc/lessons_bloc.dart';
import 'package:first_resp_api/data/models/model/lesson.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LessonPage extends StatefulWidget {
  static String route = 'home';
  LessonPage({Key key}) : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LessonssBloc, LessonState>(
      listener: (context, state) {
        if (state is LessonLoaded) _listenLoaded();
      },
      child: BlocBuilder<LessonssBloc, LessonState>(
        builder: (context, state) {
          if (state is LessonInitial) _listenInitial(context);
          if (state is LessonLoaded) return _buildLoaded(state);
          if (state is LessonError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<LessonssBloc>().add(FetchLessonScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(LessonLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lessons"),
      ),
      body: ListView.builder(
        itemCount: state.model.lessons.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.lessons[index];
          return _buildListItem(itemTask);
        },
      ),
    );
  }

  Widget _buildListItem(Lesson state) {
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

class LessonsBloc {}

class LessonBloc {}
