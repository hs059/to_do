import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyItem extends StatelessWidget {
  Task task;
  String title;

  setTitle(String value) {
    this.title = value;
  }

  String description;

  setDescription(String value) {
    this.description = value;
  }
  updateTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DBProvider>(context, listen: false).updateTask(
          Task(
            title: this.title,
            description: this.description,
            id: task.id
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
  MyItem(this.task);
GlobalKey<FormState>formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Color(0xFF0A0E30),
//         icon: Icons.delete,
          closeOnTap: true,
          iconWidget: Icon(
            Icons.delete,
            color: Color(0xFFFF0800),
          ),
          onTap: () async {
            Provider.of<DBProvider>(context, listen: false).deleteTask(task);
          },
        ),
      ],
      child: ListTile(
          title: Text(task.title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          onTap: () {
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
                          initialValue: task.title,
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
                          initialValue:task.description,
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
                        child: const Text('Update Note'),
                        onPressed: () {
                          updateTask(context);
                        })
                  ],
                );
              },
            );

          },
          subtitle: Text(
            task.description,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Checkbox(
            checkColor: Color(0xFF0A0E21),
            value: task.isComplete,
            onChanged: (value) {
              Provider.of<DBProvider>(context, listen: false).updateTask(task);
            },
          )),
    );
  }
}
