import 'package:flutter/material.dart';

class TrashScreen extends StatefulWidget {
  final List<Map<String, dynamic>> deletedTasks;
  final Function(Map<String, dynamic>) onRestoreTask;

  TrashScreen({required this.deletedTasks, required this.onRestoreTask});

  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  // دالة لاستعادة المهمة
  void _restoreTask(int index) {
    setState(() {
      Map<String, dynamic> restoredTask = widget.deletedTasks[index];
      widget.onRestoreTask(restoredTask); // استعادة المهمة عبر الcallback
      widget.deletedTasks.removeAt(index); // إزالة المهمة من سلة المهملات

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Task "${restoredTask['title']}" restored successfully.'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
        backgroundColor: Colors.blueAccent,
      ),
      body: widget.deletedTasks.isEmpty
          ? Center(
              child: Text(
                'No tasks in Trash.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: widget.deletedTasks.length,
              itemBuilder: (context, index) {
                final task = widget.deletedTasks[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(
                      task['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(task['description']),
                    trailing: IconButton(
                      icon: Icon(Icons.restore, color: Colors.green),
                      onPressed: () => _restoreTask(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
