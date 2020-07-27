import 'package:to_do/repositories/db_client.dart';

class Task {
  int id;
  String title;
  bool isComplete;

  Task({this.title, this.isComplete = false});

  Task.fromJson(Map<String, dynamic> map) {
    this.id = map[DBClient.dbClient.taskIdColumn];
    this.title = map[DBClient.dbClient.taskTitleColumn];
    this.isComplete = map[DBClient.dbClient.taskIsCompleteColumn] == 1 ? true : false;
  }

  toJson() {
    return {
      DBClient.dbClient.taskTitleColumn: this.title,
      DBClient.dbClient.taskIsCompleteColumn: this.isComplete == true ? 1 : 0,
    };
  }

  toggle() {
    this.isComplete = !this.isComplete;
  }
}
