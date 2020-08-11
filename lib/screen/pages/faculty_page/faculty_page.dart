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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = new TextEditingController();
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
      key: _scaffoldKey,
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            createAlertDialog(true, null);
          },
          child: Icon(Icons.add)),
    );
  }

  Widget _buildListItem(Faculty state) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: () {
              name.text = state.name;
              createAlertDialog(false, state);
            }),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            SnackBar mySnackbar = SnackBar(
              content: Text("${state.name} delete"),
            );
            _scaffoldKey.currentState.showSnackBar(mySnackbar);
            //Scaffold.of(context).showSnackBar(mySnackbar);
            context.bloc<FacultyBloc>().add(DeleteFacultyEvent(state));
          },
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

  createAlertDialog(bool create, Faculty department) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Faculty name"),
            content: TextField(
              controller: name,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("submit"),
                onPressed: () {
                  Navigator.of(context).pop(name.text.toString());
                  if (create) {
                    Faculty tempFaculty =
                        new Faculty(name: this.name.text.toString());
                    context
                        .bloc<FacultyBloc>()
                        .add(CreateFacultyEvent(tempFaculty));
                  } else {
                    department.name = this.name.text.toString();
                    context
                        .bloc<FacultyBloc>()
                        .add(UpdateFacultyEvent(department));

                    SnackBar mySnackbar = SnackBar(
                      content: Text("${department.name} update"),
                    );
                    _scaffoldKey.currentState.showSnackBar(mySnackbar);
                  }
                },
              )
            ],
          );
        });
  }
}
