import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  // إنشاء PageController للتحكم في التمرير بين الصفحات
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          buildPage(
            'Welcome to Task Manager',
            'Manage your tasks efficiently',
            context,
            'Get Started',
            Icons.check_circle_outline, // أيقونة معبرة
            () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          buildPage(
            'Add and Categorize Tasks',
            'Organize your tasks into categories for better productivity',
            context,
            'Next',
            Icons.list_alt, // أيقونة معبرة
            () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          buildPage(
            'Trash Management',
            'Recover deleted tasks or permanently delete them.',
            context,
            'Finish',
            Icons.delete_forever, // أيقونة معبرة
            () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget buildPage(
    String title,
    String subtitle,
    BuildContext context,
    String buttonText,
    IconData iconData, // إضافة أيقونة هنا
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // إضافة الأيقونة في الأعلى
        Icon(
          iconData,
          size: 80, // حجم الأيقونة
          color: Theme.of(context).colorScheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 30), // ترك مسافة أكبر بين النصوص والزر
        ElevatedButton.icon(
          // استخدام زر مع أيقونة
          onPressed: onPressed,
          icon: Icon(Icons.arrow_forward), // أيقونة الزر
          label: Text(buttonText),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
