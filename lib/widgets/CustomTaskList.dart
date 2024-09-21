import 'package:flutter/material.dart';

class CustomTaskList extends StatefulWidget {
  final String title;
  final String body;
  final String date;

  const CustomTaskList({
    super.key,
    required this.title,
    required this.body,
    required this.date,
  });

  @override
  _CustomTaskListState createState() => _CustomTaskListState();
}

class _CustomTaskListState extends State<CustomTaskList> {
  double _progress = 0.5; // Default progress value

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
        crossAxisAlignment: CrossAxisAlignment.center, // Center contents horizontally
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
                  Icons.today_outlined,
                  color: Colors.pink,
                  size: 50,
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Adjust size to fit content
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
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
