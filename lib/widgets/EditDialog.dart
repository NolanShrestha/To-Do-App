import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomTaskList.dart';
import 'CustomTextField.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/TaskData.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({super.key});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
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
            'Edit task',
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
              controller: _titleController,
              decoration: const InputDecoration(),
              prefixIcon: Icons.title_outlined,
              hintText: 'Enter task name',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _bodyController,
              decoration: const InputDecoration(),
              prefixIcon: Icons.description_outlined,
              hintText: 'Enter task description',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dateController,
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
            String title = _titleController.text;
            String body = _bodyController.text;
            String date = _dateController.text;

            CustomTaskList list =
            CustomTaskList(title: title, body: body, date: date);

            Provider.of<TaskData>(context, listen: false).addTask(list);
            Navigator.pop(context);
          },
          child: const Text(
            'Edit',
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
