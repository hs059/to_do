import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:to_do/ui/screens/all_tasks_tab.dart';
import 'package:to_do/ui/screens/complete_tasks_tab.dart';
import 'package:to_do/ui/screens/inComplete_tasks_tab.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String title;

  setTitle(String value) {
    this.title = value;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DBProvider>(context, listen: false).insertNewTask(
          Task(
            title: this.title,
          ),
        );
        Navigator.pop(context);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(FontAwesomeIcons.clipboardList),
          title: Text('TODO'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: '  All\nTasks',
              ),
              Tab(
                text: 'Complete\n   Tasks',
              ),
              Tab(
                text: 'InComplete\n    Tasks',
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.trash),
              onPressed: () {
                Provider.of<DBProvider>(context, listen: false).deleteAllTask();
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<DBProvider>(context).setAllLists(),
          builder: (context, snapshot) {
            return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AllTasksTab(),
                  CompleteTasksTab(),
                  InCompleteTasksTab(),
                ]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.plus,
            color: Color(0xFF0A0E21),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Color(0xFF1D1E33),
                  contentPadding: const EdgeInsets.all(16.0),
                  content: Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'text title is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Task',
                        fillColor: Color(0xFF0A0E21),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onSaved: (value) {
                        setTitle(value);
                      },
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    new FlatButton(
                        child: const Text('AddTask'),
                        onPressed: () {
                          submitTask(context);
                        })
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
