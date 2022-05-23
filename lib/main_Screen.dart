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

  String description;

  setDescription(String value) {
    this.description = value;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DBProvider>(context, listen: false).insertNewTask(
          Task(
            title: this.title,
            description: this.description,
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
          title: Text(
            'Notes',
            style: TextStyle(
              fontFamily: 'Pacifico',
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: '  All\nNotes',
              ),
              Tab(
                text: 'Complete\n   Notes',
              ),
              Tab(
                text: 'InComplete\n    Notes',
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
                physics: BouncingScrollPhysics(),
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
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'text title is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Note title',
                            fillColor: Color(0xFF0A0E21),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onSaved: (value) {
                            setTitle(value);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'text title is required';
                            }
                            return null;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'description',
                            fillColor: Color(0xFF0A0E21),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onSaved: (value) {
                            setDescription(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    new FlatButton(
                        child: const Text('Add Note'),
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
