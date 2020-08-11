import 'package:flutter/material.dart';

class DialogCustomWidget {
  final BuildContext context;
  TextEditingController name = new TextEditingController();
  TextEditingController numberLesson = new TextEditingController();
  TextEditingController dayOfWeek = new TextEditingController();
  TextEditingController customOne = new TextEditingController();
  TextEditingController customTwo = new TextEditingController();
  TextEditingController customThree = new TextEditingController();

  DialogCustomWidget(this.context);

  createAlertDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Department name"),
            content: TextField(
              controller: name,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("submit"),
                onPressed: () {
                  Navigator.of(context).pop(name.text.toString());
                },
              )
            ],
          );
        });
  }
}
