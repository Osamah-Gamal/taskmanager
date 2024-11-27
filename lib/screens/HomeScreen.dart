import 'package:flutter/material.dart';
import 'package:taskmanager/screens/EditTaskScreen.dart';
import 'package:taskmanager/screens/add_task_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> filteredTasks = [];
  List<Map<String, dynamic>> deletedTasks = [];
  TextEditingController searchController = TextEditingController();
  late User currentUser; // المستخدم الحالي

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // الحصول على بيانات المستخدم من LoginScreen
    currentUser = ModalRoute.of(context)!.settings.arguments as User;
  }

  @override
  void initState() {
    super.initState();
    filteredTasks = tasks; // عرض جميع المهام في البداية
  }

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      tasks.add(task); // إضافة المهمة إلى القائمة
      filteredTasks = tasks; // تحديث القائمة المعروضة
    });
  }

  void _deleteTask(int index) {
    setState(() {
      deletedTasks.add(tasks[index]); // إضافة المهمة إلى المهملات
      tasks.removeAt(index); // حذف المهمة من القائمة
      filteredTasks = tasks; // تحديث القائمة المعروضة
    });
  }

  void _editTask(int index) {
    Map<String, dynamic> task = tasks[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          task: task,
          onSaveTask: (updatedTask) {
            setState(() {
              tasks[index] = updatedTask; // تحديث المهمة بعد التعديل
              filteredTasks = tasks; // تحديث القائمة المعروضة
            });
          },
        ),
      ),
    );
  }

  void _filterTasks(String query) {
    setState(() {
      filteredTasks = tasks
          .where((task) =>
              task['title'].toLowerCase().contains(query.toLowerCase()) ||
              task['description'].toLowerCase().contains(query.toLowerCase()))
          .toList(); // تحديث القائمة بناءً على النص المدخل
    });
  }

  void _viewDetails(int index) {
    final task = tasks[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${task['description']}'),
            const SizedBox(height: 10),
            Text('Start Date: ${task['startDate']}'),
            Text('End Date: ${task['endDate']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Task Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      currentUser.username, // عرض البريد الإلكتروني
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      overflow:
                          TextOverflow.ellipsis, // التأكد من عدم التمدد المفرط
                      maxLines: 1, // تحديد عدد الأسطر
                    ),
                  ),
                  Flexible(
                    child: Text(
                      currentUser.email, // عرض الأيميل
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                      overflow:
                          TextOverflow.ellipsis, // التأكد من عدم التمدد المفرط
                      maxLines: 1, // تحديد عدد الأسطر
                    ),
                  ),
                ],
              ),
            ),
            _drawerItem(Icons.delete, 'Trash', '/trash'),
            _drawerItem(Icons.settings, 'Settings', '/settings'),
            _drawerItem(Icons.logout, 'Logout', '/login'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterTasks,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  // borderSide: BorderSide.none,
                  borderSide:
                      BorderSide(color: Colors.black), // تغيير اللون إلى الأسود
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ),
          filteredTasks.isEmpty
              ? Center(
                  child: Text(
                    'No tasks available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            task['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(task['description']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.info, color: Colors.green),
                                onPressed: () => _viewDetails(index),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editTask(index),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteTask(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                onAddTask: _addTask,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
