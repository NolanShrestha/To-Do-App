import 'package:flutter/material.dart';
import 'register.dart';
import 'package:untitled/widgets/CustomTextField.dart';
import 'package:untitled/widgets/CustomButton.dart';
import 'screen1.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled/address.dart';
import 'dart:convert';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://$ip:3000/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      await storage.write(key: 'jwt', value: responseData['token']);
      final userId = responseData['userId'];

      print('${response.body}');

      if (userId != null) {
        setState(() {
          Navigator.of(context).push(_createRoute2())
          as Route<Object?>;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: ${response.body}')),
      );
      print('${response.body}');
    }
  }

    Route _createRoute1() {
      return PageRouteBuilder(
        pageBuilder: (context, animation,
            secondaryAnimation) => const Register(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    Route _createRoute2() {
      return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 600),
        pageBuilder: (context, animation,
            secondaryAnimation) => const Screen1(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade animation
          const begin = 0.0; // Start fully transparent
          const end = 1.0; // End fully opaque
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve));

          // Animate the opacity
          var opacityAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: opacityAnimation,
            child: child,
          );
        },
      );
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'To-Do List',
                    style: TextStyle(
                        color: Color(0xFFF27F01),
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 2),
                const Center(
                  child: Text(
                    'Your go-to to-do app',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 220,
                  height: 220,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/logo.jpeg'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomTextField(
                    obscureText: false,
                    decoration: InputDecoration(),
                    prefixIcon: Icons.mark_email_read,
                    hintText: 'Enter your email',
                    controller: emailController,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomTextField(
                    obscureText: true,
                    decoration: InputDecoration(),
                    prefixIcon: Icons.lock_person,
                    hintText: 'Enter your password',
                    controller: passwordController,
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    backgroundColor: const Color(0xFFF27F01),
                    foregroundColor: Colors.white,
                    text: 'Sign-in',
                    color: Colors.white,
                    onPressed: login,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).push(_createRoute1())
                            as Route<Object?>;
                          });
                        },
                        child: const Text(
                          'Sign-Up',
                          style: TextStyle(
                            color: Color(0xFFF27F01),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}