import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomTaskList.dart';
import 'CustomTextField.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/TaskData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled/address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final storage = const FlutterSecureStorage();
  List<Map<dynamic, dynamic>> userTasks = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchUserTasks();
  }

  Future<void> fetchUserData() async {
    final token = await storage.read(key: 'jwt');

    if (token == null) {
      print('No token found');
      return;
    }
  }

  Future<void> fetchUserTasks() async {
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
        userTasks = responseData.cast<Map<String, dynamic>>();
      });
    } else {
      print('Failed to fetch tasks: ${response.body}');
    }
  }

  Future<void> _createTask() async {
    final token = await storage.read(key: 'jwt');
    final title = titleController.text;
    final body = bodyController.text;
    final date = dateController.text;

    if (token == null) {
      Fluttertoast.showToast(msg: 'No token found');
      return;
    }

    final response = await http.post(
      Uri.parse('http://$ip:3000/auth/tasks'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
        'date' : date,
      }),
    );

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: 'Task created successfully');
      titleController.clear();
      bodyController.clear();
      dateController.clear();
      fetchUserTasks();
    } else {
      Fluttertoast.showToast(msg: 'Failed to create task: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(
            Icons.task_alt_outlined,
            size: 40,
            color: Color(0xFFF27F01),
          ),
          SizedBox(width: 10),
          Text(
            'Add task',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              obscureText: false,
              controller: titleController,
              decoration: const InputDecoration(),
              prefixIcon: Icons.title_outlined,
              hintText: 'Enter task name',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              obscureText: false,
              controller: bodyController,
              decoration: const InputDecoration(),
              prefixIcon: Icons.description_outlined,
              hintText: 'Enter task description',
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: false,
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: const Icon(
                    Icons.date_range,
                  ),
                ),
                hintText: 'Enter due date',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFF27F01),
                    width: 5.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            String title = titleController.text;
            String body = bodyController.text;
            String date = dateController.text;

            CustomTaskList list =
            CustomTaskList(title: title, body: body, date: date);

            Provider.of<TaskData>(context, listen: false).addTask(list);
            _createTask();
            Navigator.pop(context);
          },
          child: const Text(
            'OK',
            style: TextStyle(
              color: Color(0xFFF27F01),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'CANCEL',
            style: TextStyle(
              color: Color(0xFFF27F01),
            ),
          ),
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 25,
    );
  }
}