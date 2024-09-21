import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomProgress.dart';
import 'package:untitled/widgets/CustomAppBar.dart';
import 'package:untitled/models/TaskData.dart';
import 'package:provider/provider.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  Screen2State createState() => Screen2State();
}

class Screen2State extends State<Screen2> {

  void sortTasksByDate1() {
    var taskData = Provider.of<TaskData>(context, listen: false);
    taskData.savedTasks.sort((a, b) => b.date.compareTo(a.date));
    setState(() {});
  }

  void sortTasksByDate2() {
    var taskData = Provider.of<TaskData>(context, listen: false);
    taskData.savedTasks.sort((a, b) => a.date.compareTo(b.date));
    setState(() {});
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
                const CustomAppBar(
                  icon: Icons.arrow_back,
                  text: 'To-Do tasks',
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    sortTasksByDate1();
                  },
                  onDoubleTap: () {
                    sortTasksByDate2();
                  },
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final task = savedTasks[index];
                    return CustomProgress(
                      title: task.title,
                      body: task.body,
                      date: task.date,
                    );
                  },
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 10),
                  itemCount: savedTasks.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
