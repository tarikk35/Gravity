import 'package:flutter/material.dart';
import './ui/main_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(unselectedWidgetColor: Colors.white70),
      debugShowCheckedModeBanner: false,
      title: 'My Weight on Planets',
      home: MainPage(),
    );
  }
}