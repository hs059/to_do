import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class MyItem extends StatelessWidget{
  Task task;
  MyItem(this.task);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Slidable(
     actionPane: SlidableDrawerActionPane(),
     actionExtentRatio: 0.25,
     actions: <Widget>[
       IconSlideAction(
         caption: 'Delete',
         color: Colors.red,
         icon: Icons.delete,closeOnTap: true,
         onTap: () async {
//           Provider.of<DBProvider>(context,listen: false).deleteTask(task);
         },
       ),
     ],


     child: ListTile(
       leading: IconButton(icon: Icon(Icons.delete), onPressed: (){
         Provider.of<DBProvider>(context,listen: false).deleteTask(task);
       }),
         title: Text(task.title),
         trailing: Checkbox(
           checkColor: Color(0xFF0A0E21),
           value: task.isComplete,
           onChanged: (value){
             Provider.of<DBProvider>(context,listen: false).updateTask(task);
           },)
     ),
   );
  }

}