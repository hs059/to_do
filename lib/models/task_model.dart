import 'package:to_do/repositories/db_client.dart';

class Task {
  int id;
  String title;
  String description;
  bool isComplete;

  Task({this.title, this.isComplete = false,this.description,this.id});

  Task.fromJson(Map<String, dynamic> map) {
    this.id = map[DBClient.dbClient.taskIdColumn];
    this.title = map[DBClient.dbClient.taskTitleColumn];
    this.description = map[DBClient.dbClient.taskDescriptionColumn];
    this.isComplete = map[DBClient.dbClient.taskIsCompleteColumn] == 1 ? true : false;
  }

  toJson() {
    return {
      DBClient.dbClient.taskTitleColumn: this.title,
      DBClient.dbClient.taskDescriptionColumn: this.description,
      DBClient.dbClient.taskIsCompleteColumn: this.isComplete == true ? 1 : 0,
    };
  }

  toggle() {
    this.isComplete = !this.isComplete;
  }
}
