import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

class TaskInputScreen extends StatefulWidget {
  @override
  _TaskInputScreenState createState() => _TaskInputScreenState();
}

class _TaskInputScreenState extends State<TaskInputScreen> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedPriority = 'Medium';
  DateTime? _selectedDate;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitTask() {
    if (_taskController.text.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all details')),
      );
      return;
    }
    print('Task: ${_taskController.text}, Priority: $_selectedPriority, Date: $_selectedDate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              items: ['Low', 'Medium', 'High'].map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Priority'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen'
                      : 'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}', // Correctly formatted date
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text('Pick Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitTask,
                child: Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
