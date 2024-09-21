import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/TaskData.dart';
import 'package:untitled/models/CompletedData.dart';
import 'package:untitled/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(create: (context) => TaskData()),
        ChangeNotifierProvider<CompletedData>(create: (context) => CompletedData()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
