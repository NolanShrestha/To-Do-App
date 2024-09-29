import 'package:flutter/material.dart';
import 'login.dart';
import 'package:untitled/widgets/CustomTextField.dart';
import 'package:untitled/widgets/CustomButton.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Register(),
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  Route _createRoute1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 18),
                const Center(
                  child: Text(
                    'To-Do List',
                    style: TextStyle(
                      color: Color(0xFFF27F01),
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Center(
                  child: Text(
                    'Your go-to to-do app',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 120,
                  height: 120,
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
                    decoration: InputDecoration(),
                    prefixIcon: Icons.account_box,
                    hintText: 'Enter your name',
                    controller: _nameController,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomTextField(
                    decoration: InputDecoration(),
                    prefixIcon: Icons.mail,
                    hintText: 'Enter your email',
                    controller: _emailController,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomTextField(
                    decoration: InputDecoration(),
                    prefixIcon: Icons.lock,
                    hintText: 'Enter your password',
                    controller: _passwordController1,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomTextField(
                    decoration: InputDecoration(),
                    prefixIcon: Icons.lock_open_outlined,
                    hintText: 'Re-enter your password',
                    controller: _passwordController2,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    backgroundColor: const Color(0xFFF27F01),
                    foregroundColor: Colors.white,
                    color: Colors.white,
                    text: 'Register',
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(_createRoute1())
                        as Route<Object?>;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
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
                          'Sign-In',
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
      ),
    );
  }
}
