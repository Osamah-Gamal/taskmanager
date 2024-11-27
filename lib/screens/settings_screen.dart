import 'package:flutter/material.dart';
import 'package:taskmanager/screens/Privacy.dart';
import 'package:taskmanager/screens/about_us.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  SettingsScreen({required this.isDarkMode, required this.onDarkModeChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: widget.isDarkMode,
              onChanged: (value) {
                widget.onDarkModeChanged(value); // تمرير القيمة للمستوى الأعلى
              },
            ),
            DropdownButtonFormField<String>(
              value: language,
              items: ['English', 'Arabic'].map((lang) {
                return DropdownMenuItem(value: lang, child: Text(lang));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  language = value!; // تغيير اللغة
                });
              },
              decoration: InputDecoration(labelText: 'Language'),
            ),
            ListTile(
              title: Text('Privacy'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()),
                );
              },
            ),
            ListTile(
              title: Text('About Developers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
                // Navigate to developer info
              },
            ),
          ],
        ),
      ),
    );
  }
}
