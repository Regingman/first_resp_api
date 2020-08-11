import 'package:first_resp_api/bloc/departments_bloc/departments_bloc.dart';
import 'package:first_resp_api/data/models/model/department.dart';
import 'package:first_resp_api/data/models/model/faculty.dart';
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
  bool flag = false;
  TextEditingController name = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<Faculty>> _dropDownItems = [];
  Faculty selected;

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
    if (!flag) {
      _dropDownItems = buildDropdownMenuItems(state.model.faculties);
      selected = _dropDownItems[0].value;
      flag = true;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Departments"),
      ),
      body: ListView.builder(
        itemCount: state.model.departments.length,
        itemBuilder: (_, index) {
          final itemTask = state.model.departments[index];
          return _buildListItem(itemTask, state.model.faculties);
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            createAlertDialog(true, null, state.model.faculties);
          },
          child: Icon(Icons.add)),
    );
  }

  Widget _buildListItem(Department state, List<Faculty> faculties) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: () {
              name.text = state.name;
              createAlertDialog(false, state, faculties);
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
            context.bloc<DepartmentBloc>().add(DeleteDepartmetnEvent(state));
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
          subtitle: Text("and faculty id ${state.id_faculty}"),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Faculty>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Faculty>> items = List();
    for (Faculty company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDepartment(Faculty faculty) {
    setState(() {
      selected = faculty;
    });
  }

  createAlertDialog(
      bool create, Department department, List<Faculty> faculties) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(create ? "Create" : "Update"),
            content: Container(
              child: Column(
                children: <Widget>[
                  Text("Name"),
                  TextField(
                    controller: name,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Faculty"),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButton(
                      value: selected,
                      items: _dropDownItems,
                      onChanged: (Faculty newValue) {
                        setState(() {
                          selected = newValue;
                          print(selected.id);
                          print(selected.name);
                        });
                      }),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text("submit"),
                  onPressed: () {
                    print(selected.id);
                    print(selected.name);
                    Navigator.of(context).pop(name.text.toString());
                    if (create) {
                      Department tempDepartment = new Department(
                        id_faculty: selected.id,
                        name: this.name.text.toString(),
                      );
                      context
                          .bloc<DepartmentBloc>()
                          .add(CreateDepartmentEvent(tempDepartment));
                    } else {
                      department.id_faculty = selected.id;
                      department.name = this.name.text.toString();
                      context
                          .bloc<DepartmentBloc>()
                          .add(UpdateDepartmentEvent(department));
                      SnackBar mySnackbar = SnackBar(
                        content: Text("${department.name} update"),
                      );
                      _scaffoldKey.currentState.showSnackBar(mySnackbar);
                    }
                  })
            ],
          );
        });
      },
    );
  }
}
