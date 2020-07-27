import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/db_provider.dart';

import 'main_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBProvider>(
      create: (BuildContext context) => DBProvider(),
      child: MaterialApp(
        theme:ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          accentColor: Color(0xFFef233c),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          sliderTheme: SliderTheme.of(context),
          textTheme: TextTheme(
            body1:TextStyle(
              //color:Colors.orange,
              // fontSize: 44,
            ) ,
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}