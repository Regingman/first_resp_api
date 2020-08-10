import 'package:first_resp_api/bloc/home_bloc/home_bloc.dart';
import 'package:first_resp_api/screen/pages/department_page/department_page.dart';
import 'package:first_resp_api/screen/pages/faculty_page/faculty_page.dart';
import 'package:first_resp_api/screen/pages/group_page/group_page.dart';
import 'package:first_resp_api/screen/pages/lesson_page/lesson_page.dart';
import 'package:first_resp_api/screen/pages/list_lesson_page/list_lesson_page.dart';
import 'package:first_resp_api/screen/pages/teacher_page/teacher_page.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String route = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) _listenLoaded();
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) _listenInitial(context);
          if (state is HomeLoaded) return _buildLoaded(state);
          if (state is HomeError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<HomeBloc>().add(FetchHomeScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(HomeState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("University"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(120.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FacultyPage(),
                          ),
                        );
                      },
                      child: Text("Faculty"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DepartmentPage(),
                          ),
                        );
                      },
                      child: Text("Department"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GroupPage(),
                          ),
                        );
                      },
                      child: Text("Group"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TeacherPage(),
                          ),
                        );
                      },
                      child: Text("teacher"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LessonPage(),
                          ),
                        );
                      },
                      child: Text("lesson"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListLessonPage(),
                          ),
                        );
                      },
                      child: Text("list lesson"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
