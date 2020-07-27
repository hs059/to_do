import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/repositories/db_repository.dart';

class DBProvider extends ChangeNotifier {
  List<Task> allTasks = [];
  List<Task> completeTasks = [];
  List<Task> inCompleteTasks = [];

  setAllLists() async {
    this.allTasks = await DBRepository.dbRepository.getAllData();
    this.completeTasks = await DBRepository.dbRepository.getCompleteTasks();
    this.inCompleteTasks = await DBRepository.dbRepository.getInCompleteTasks();
    notifyListeners();
  }

  insertNewTask(Task task) async {
    await DBRepository.dbRepository.insertNewTask(task);
    setAllLists();
  }

  updateTask(Task task) async {
    await DBRepository.dbRepository.updateTask(task);
    setAllLists();
  }

  deleteTask(Task task) async {
    await DBRepository.dbRepository.deleteTask(task);
    setAllLists();
  }

  deleteAllTask() async {
    await DBRepository.dbRepository.deleteAllTask();
    setAllLists();
  }
}
