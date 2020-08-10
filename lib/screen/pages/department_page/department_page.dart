import 'package:first_resp_api/bloc/departments_bloc/departments_bloc.dart';
import 'package:first_resp_api/data/models/model/department.dart';
import 'package:first_resp_api/screen/widgets/error_screen.dart';
import 'package:first_resp_api/screen/widgets/screen_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DepartmentPage extends StatefulWidget {
  static String route = 'home';
  DepartmentPage({Key key}) : super(key: key);

  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DepartmentBloc, DepartmentState>(
      listener: (context, state) {
        if (state is DepartmentLoaded) _listenLoaded();
      },
      child: BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) {
          if (state is DepartmentInitial) _listenInitial(context);
          if (state is DepartmentLoaded) return _buildLoaded(state);
          if (state is DepartmentError) return ErrorScreen(state.message);
          return ScreenLoading();
        },
      ),
    );
  }

  void _listenInitial(BuildContext context) {
    context.bloc<DepartmentBloc>().add(FetchDepartmentScreenData());
  }

  void _listenLoaded() {}

  Widget _buildLoaded(DepartmentLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Departments"),
      ),
      body: ListView.builder(
        itemCount: state.model.departments.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.departments[index];
          return _buildListItem(itemTask);
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: null,
          child: Icon(Icons.add)),
    );
  }

  Widget _buildListItem(Department state) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => {},
        ),
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
