import 'package:first_resp_api/screen/app_config.dart';
import 'package:first_resp_api/screen/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/departments_bloc/departments_bloc.dart';
import 'bloc/faculties_bloc/faculties_bloc.dart';
import 'bloc/groups_bloc/groups_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/lessons_bloc/lessons_bloc.dart';
import 'bloc/list_lessons_bloc/list_lessons_bloc.dart';
import 'bloc/teachers_bloc/teachers_bloc.dart';
import 'data/repositories/repositories.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(context.repository<Repository>()),
          ),
          BlocProvider(
            create: (context) => FacultyBloc(context.repository<Repository>()),
          ),
          BlocProvider(
            create: (context) =>
                DepartmentBloc(context.repository<Repository>()),
          ),
          BlocProvider(
            create: (context) => GroupsBloc(context.repository<Repository>()),
          ),
          BlocProvider(
            create: (context) => TeacherBloc(context.repository<Repository>()),
          ),
          BlocProvider(
            create: (context) => LessonssBloc(context.repository<Repository>()),
          ),
          BlocProvider(
            create: (context) =>
                ListLessonssBloc(context.repository<Repository>()),
          ),
        ],
        child: MaterialApp(
          theme: getTheme(),
          home: HomePage(),
          routes: getRoutes(),
        ),
      ),
    );
  }
}
