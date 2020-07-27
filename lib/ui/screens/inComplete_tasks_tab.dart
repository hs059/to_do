
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:to_do/ui/myItem.dart';

class InCompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, value, child) {
        List<Task> allTasks = value.inCompleteTasks;
        return ListView.builder(
          itemCount: allTasks.length,
          itemBuilder: (context, index) {
            return MyItem(allTasks[index]);
          },);
      },
    );
  }
}
