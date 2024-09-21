import 'package:flutter/material.dart';
import 'CustomButton.dart';
import 'CustomCompleted.dart';
import 'package:untitled/models/CompletedData.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/TaskData.dart';

class CustomProgress extends StatefulWidget {
  final String title;
  final String body;
  final String date;

  const CustomProgress({
    super.key,
    required this.title,
    required this.body,
    required this.date,
  });

  @override
  State<CustomProgress> createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress> {
  double currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.center, // Center contents horizontally
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.view_list_outlined,
                  color: Colors.pink,
                  size: 50,
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min, // Adjust size to fit content
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.body,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timelapse_outlined,
                            color: Colors.black87,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: currentSliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                  activeColor: const Color(0xFF5F33E2),
                  inactiveColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '0',
                      style: TextStyle(fontSize: 16),
                    ),
                    Center(
                      child: Text(
                        currentSliderValue.round().toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5F33E2),
                        ),
                      ),
                    ),
                    const Text(
                      '100',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                backgroundColor: const Color(0xFFDE496E),
                foregroundColor: Colors.white,
                color: Colors.white,
                text: 'Task Completed',
                onPressed: () {
                  CustomCompleted list =
                  CustomCompleted(title: widget.title, body: widget.body, date: widget.date);

                  Provider.of<CompletedData>(context, listen: false).addTask(list);
                  Provider.of<TaskData>(context, listen: false).removeTask(widget.title);
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                backgroundColor: const Color(0xFFDE496E),
                foregroundColor: Colors.white,
                color: Colors.white,
                text: 'Edit Task',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CustomButton(
                backgroundColor: const Color(0xFFDE496E),
                foregroundColor: Colors.white,
                color: Colors.white,
                text: 'Delete Task',
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false).removeTask(widget.title);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
