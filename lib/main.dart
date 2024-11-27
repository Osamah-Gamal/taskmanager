import 'package:flutter/material.dart';
import 'package:taskmanager/screens/Privacy.dart';
import 'package:taskmanager/screens/about_us.dart';
import 'package:taskmanager/screens/login_screen.dart';
import 'package:taskmanager/screens/register_screen.dart';
import 'package:taskmanager/screens/reset_password_screen.dart';
import 'package:taskmanager/screens/HomeScreen.dart';
import 'package:taskmanager/screens/add_task_screen.dart';
import 'package:taskmanager/screens/settings_screen.dart';
import 'package:taskmanager/screens/trash_screen.dart';
import 'package:taskmanager/screens/introduction_screen.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatefulWidget {
  @override
  _TaskManagerAppState createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  bool isDarkMode = false; // حالة الوضع المظلم
  List<User> users = []; // قائمة المستخدمين المشتركة بين الشاشات

  // دالة لتحديث الوضع المظلم
  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueGrey,
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => IntroductionScreen(),
        '/privacy': (context) => PrivacyPolicyScreen(),
        '/about_us': (context) =>
            AboutUsScreen(), // إضافة المسار لصفحة About Us
        '/login': (context) =>
            LoginScreen(users: users), // تمرير قائمة المستخدمين
        '/register': (context) => RegisterScreen(
              users: users, // تمرير قائمة المستخدمين
            ),
        '/reset_password': (context) => ResetPasswordScreen(),
        '/home': (context) => HomeScreen(),
        '/add_task': (context) => AddTaskScreen(onAddTask: (task) {}),
        '/settings': (context) => SettingsScreen(
              isDarkMode: isDarkMode,
              onDarkModeChanged: _toggleDarkMode,
            ),
        '/trash': (context) =>
            TrashScreen(deletedTasks: [], onRestoreTask: (task) {}),
      },
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Task Manager"),
            actions: [
              Switch(
                value: isDarkMode,
                onChanged: _toggleDarkMode,
                activeColor: Colors.yellow,
                inactiveThumbColor: Colors.blue,
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Task Manager",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Manage your tasks efficiently",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("Get Started"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/about_us'); // رابط لصفحة About Us
                  },
                  child: const Text("About Us"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
