import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:to_do/models/task_model.dart';

class DBClient {
  DBClient._();

  static final DBClient dbClient = DBClient._();

  final String taskTableName = 'tasks';
  final String taskTitleColumn = 'taskTitle';
  final String taskDescriptionColumn = 'taskDescription';
  final String taskIdColumn = 'taskId';
  final String taskIsCompleteColumn = 'taskComplete';

  Database database;

  initDatabase() async {
    if (database == null) {
      database = await connectToDatabase();
      return database;
    } else {
      return database;
    }
  }

        Future <Database> connectToDatabase() async {
          Directory directory = await getApplicationDocumentsDirectory();
          String path = join(directory.path, 'tasksDp.dp');
          Database database = await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) {
              db.execute('''CREATE TABLE $taskTableName(
          $taskIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $taskTitleColumn TEXT NOT NULL,
          $taskDescriptionColumn TEXT NOT NULL,
          $taskIsCompleteColumn INTEGER NOT NULL
      )''');

            },
          );
          return database ;
        }
  Future <int>  insertNewTask(Map <String,dynamic> map)async {
    try{
      database = await initDatabase();
      int rowIndex = await database.insert(taskTableName, map) ;
      return rowIndex ;
    } catch (error){
      throw 'error is $error';
    }

  }
  Future <List<Map<String, dynamic>>> getAllTasks()async {
 try {
   database = await initDatabase();
   List<Map<String, dynamic>> results = await database.query(taskTableName);
   return results ;
 } catch (error){
   throw 'error is $error';
 }

  }
  Future <List<Map<String, dynamic>>> getCompleteTasks()async {
    try {
      database = await initDatabase();
      List<Map<String, dynamic>> results =
      await database.query(taskTableName,where: '$taskIsCompleteColumn = ?',whereArgs: [1]);
      return results ;
    } catch (error){
      throw 'error is $error';
    }
  }

  Future <List<Map<String, dynamic>>> getInCompleteTasks()async {
    try {
      database = await initDatabase();
      List<Map<String, dynamic>> results =
      await database.query(taskTableName,where: '$taskIsCompleteColumn = ?',whereArgs: [0]);
      return results ;
    } catch (error){
      throw 'error is $error';
    }
  }
  Future<int> updateTask(int id,Map<String,dynamic> map)async{
   try{
     database = await initDatabase();
     int rows =await database.update(taskTableName,map,where: '$taskIdColumn = ?',whereArgs: [id] ) ;
     return rows ;

   }catch (error){
     throw 'error is $error';
   }

  }
  Future<int> deleteTask(int id)async{
    try{
      database = await initDatabase();
      int rows =await database.delete(taskTableName,where: '$taskIdColumn = ?',whereArgs: [id] ) ;
      return rows ;
    }catch (error){
      throw 'error is $error';
    }

  }
  Future<int> deleteAllTask()async{
    try{
      database = await initDatabase();
      int rows =await database.delete(taskTableName) ;
      return rows ;
    }catch (error){
      throw 'error is $error';
    }

  }


}
