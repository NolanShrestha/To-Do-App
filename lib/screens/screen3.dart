import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomCompleted.dart';
import 'package:untitled/widgets/CustomAppBar.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  Screen3State createState() => Screen3State();
}

class Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomAppBar(
                  icon: Icons.arrow_back,
                  text: 'Completed tasks',
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  onDoubleTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDE496E),
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4), // Adds elevation effect
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Sort Tasks By Date',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.swap_vert_circle_outlined,
                            color: Color(0xFFDE496E),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const CustomCompleted(
                  title: 'Task 1',
                  body: 'Body 1',
                  date: '2023-2-17',
                ),
                const CustomCompleted(
                  title: 'Task 2',
                  body: 'Body 2',
                  date: '2024-1-14',
                ),
                const CustomCompleted(
                  title: 'Task 3',
                  body: 'Body 3',
                  date: '2023-6-3',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
