import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Team Member
              _buildTeamMember(
                name: 'أسامة جمال',
                title: 'Developer',
                contactInfo: 'Email: osamajamal2021@gmail.com',
              ),
              SizedBox(height: 20),

              // Second Team Member
              _buildTeamMember(
                name: 'محمد بن طرش',
                title: 'Lead Developer',
                contactInfo: 'Email: mohammed.bentorsh@example.com',
              ),
              SizedBox(height: 20),

              // Third Team Member
              _buildTeamMember(
                name: 'مهدي أمذيب',
                title: 'Product Manager',
                contactInfo: 'Email: mehdi.amzib@example.com',
              ),
              SizedBox(height: 20),

              // Fourth Team Member
              _buildTeamMember(
                name: 'وليد عادل',
                title: 'Marketing Manager',
                contactInfo: 'Email: walid.adel@example.com',
              ),
              SizedBox(height: 20),

              // Fifth Team Member
              _buildTeamMember(
                name: 'محمد دهول',
                title: 'UX/UI Designer',
                contactInfo: 'Email: mohammed.dahoul@example.com',
              ),
              SizedBox(height: 20),

              // Sixth Team Member
              _buildTeamMember(
                name: 'محمد الشماسي',
                title: 'Customer Support',
                contactInfo: 'Email: mohammed.ashmasee@example.com',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String title,
    required String contactInfo,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        Text(
          contactInfo,
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }
}
