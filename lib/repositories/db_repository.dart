

import 'package:to_do/models/task_model.dart';
import 'package:to_do/repositories/db_client.dart';

class DBRepository{
  DBRepository._();
 static final DBRepository dbRepository = DBRepository._() ;
insertNewTask(Task task)async{
  await DBClient.dbClient.insertNewTask(task.toJson());
}
Future<List<Task>> getAllData()async{
  List<Map<String, dynamic>> results = await DBClient.dbClient.getAllTasks();
  List<Task> tasks = results.map((e) => Task.fromJson(e)).toList();
  return tasks ;
}
Future<List<Task>> getCompleteTasks()async{
  List<Map<String, dynamic>> results = await DBClient.dbClient.getCompleteTasks();
  List<Task> tasks = results.map((e) => Task.fromJson(e)).toList();
  return tasks ;
}
Future<List<Task>> getInCompleteTasks()async{
  List<Map<String, dynamic>> results = await DBClient.dbClient.getInCompleteTasks();
  List<Task> tasks = results.map((e) => Task.fromJson(e)).toList();
  return tasks ;
}
//convert map to task ;
 Future<int> updateTask(Task task)async{
  task.toggle();
    int x =await DBClient.dbClient.updateTask(task.id, task.toJson());
    print(x);
    return x;

  }


  Future<int> deleteTask(Task task)async{
    int x= await DBClient.dbClient.deleteTask(task.id);
    print('$x ooooo');
    return x ;
  }
   deleteAllTask()async{
    await DBClient.dbClient.deleteAllTask();
  }


}
