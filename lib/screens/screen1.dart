import 'package:flutter/material.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/widgets/CustomNavBar.dart';
import 'package:untitled/widgets/CustomButton.dart';
import 'package:untitled/widgets/CustomDialog.dart';
import 'package:untitled/widgets/CustomTaskList.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/TaskData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled/address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Screen1(),
      ),
    );
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  String userName = '';
  String userEmail = '';
  int completedTasks = 0;
  List<Map<String, dynamic>> tasks = [];
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchTasks();
  }

  Future<void> fetchUserData() async {
    final token = await storage.read(key: 'jwt');

    if (token == null) {
      print('No token found');
      return;
    }

    final response = await http.get(
      Uri.parse('http://$ip:3000/auth/me'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        userName = responseData['name'];
        userEmail = responseData['email'];
      });
    } else {
      print('Failed to fetch user data: ${response.body}');
    }
  }

  Future<void> fetchTasks() async {
    final token = await storage.read(key: 'jwt');

    if (token == null) {
      print('No token found');
      return;
    }

    final response = await http.get(
      Uri.parse('http://$ip:3000/auth/tasks?status=0'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as List;
      setState(() {
        tasks = responseData.map((task) {
          return {
            'title': task['title'], // Ensure these fields exist in your API response
            'body': task['body'],
            'date': task['date'],
          };
        }).toList().cast<Map<String, dynamic>>();
      });
    } else {
      print('Failed to fetch tasks: ${response.body}');
    }
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'jwt');
    Navigator.of(context).push(_createRoute1())
    as Route<Object?>;
  }

  Route _createRoute1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0; // Start with no scale
        const end = 1.0; // End with full scale
        const curve = Curves.ease;

        // Create a Tween for scaling
        var scaleTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // Animate the scale
        var scaleAnimation = animation.drive(scaleTween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  Route _createRoute2() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Screen2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0; // Start with no scale
        const end = 1.0; // End with full scale
        const curve = Curves.ease;

        // Create a Tween for scaling
        var scaleTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // Animate the scale
        var scaleAnimation = animation.drive(scaleTween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  Route _createRoute3() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Screen3(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0; // Start with no scale
        const end = 1.0; // End with full scale
        const curve = Curves.ease;

        // Create a Tween for scaling
        var scaleTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // Animate the scale
        var scaleAnimation = animation.drive(scaleTween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var savedTasks = Provider.of<TaskData>(context).savedTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/logo.jpeg'),
                    ),
                    const SizedBox(width: 16),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          logout();
                        });
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFD8748D), // Ensure the color is correct (consider changing it if needed)
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 6, 5, 6), // Adjusted side padding for consistency
                              child: Center(
                                child: Text(
                                  (Provider.of<TaskData>(context).taskCount > 0)
                                      ? "Keep going! You still have tasks\nto complete!"
                                      : "Hurray! Your today's tasks\nare almost done!",
                                  textAlign: TextAlign.center, // Center align the text
                                  style: TextStyle(
                                    color: const Color(0xFFEDE8FF),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16), // Add spacing between the text and the button
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(_createRoute2())
                            as Route<Object?>;
                          });
                        },
                        backgroundColor: const Color(0xFFEDE8FF),
                        foregroundColor: Colors.black, // Change text color to black for better contrast
                        text: 'View Tasks',
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'In progress',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 15),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          '${Provider.of<TaskData>(context).taskCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Retrieve each task from savedTasks and display it using CustomTaskList
                    final task = savedTasks[index];
                    return CustomTaskList(
                      title: task.title,
                      body: task.body,
                      date: task.date,
                    );
                  },
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 2),
                  itemCount: savedTasks.length,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        color: const Color(0xFFECE6FE),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomNavBar(
                icon: Icons.list_alt_outlined,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(_createRoute2())
                    as Route<Object?>;
                  });
                },
              ),
              CustomNavBar(
                icon: Icons.checklist_outlined,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(_createRoute3())
                    as Route<Object?>;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialog();
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}