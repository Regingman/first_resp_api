import 'package:first_resp_api/bloc/faculties_bloc/faculties_bloc.dart';
import 'package:first_resp_api/data/models/model/faculty.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FacultyPage extends StatefulWidget {
  static String route = 'home';
  FacultyPage({Key key}) : super(key: key);

  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FacultyBloc, FacultyState>(
      listener: (context, state) {
        if (state is FacultyLoaded) _listenLoaded();
      },
      child: BlocBuilder<FacultyBloc, FacultyState>(
        builder: (context, state) {
          if (state is FacultyInitial) _listenInitial(context);
          if (state is FacultyLoaded) return _buildLoaded(state);
          if (state is FacultyError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<FacultyBloc>().add(FetchFacultyScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(FacultyLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faculties"),
      ),
      body: ListView.builder(
        itemCount: state.model.faculty.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.faculty[index];
          return _buildListItem(itemTask);
        },
      ),
    );
  }

  Widget _buildListItem(Faculty state) {
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
