import 'package:flutter/material.dart';

class QuickActionPage extends StatelessWidget {
  const QuickActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Top blue container
              Container(
                width: double.infinity,
                height: size.height * 0.22,
                color: const Color.fromARGB(255, 8, 66, 114),
                child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.07),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Quick Action',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              // Red container below
              Container(
                height: size.height * 0.625,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 30.0, 22.0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        QuickActionItem(
                          icon: Icons.local_hospital,
                          title: 'Health Professionals',
                          onTap: () {
                            // Navigate to Health Professionals screen or functionality
                          },
                        ),
                        QuickActionItem(
                          icon: Icons.psychology,
                          title: 'Counsellors',
                          onTap: () {
                            // Navigate to Counsellors screen or functionality
                          },
                        ),
                        QuickActionItem(
                          icon: Icons.school,
                          title: 'Academic Mentors',
                          onTap: () {
                            // Navigate to Academic Mentors screen or functionality
                          },
                        ),
                        QuickActionItem(
                          icon: Icons.admin_panel_settings,
                          title: 'Administrators',
                          onTap: () {
                            // Navigate to Administrators screen or functionality
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Positioned container with 'Registered Professionals' text
          Positioned(
            top: size.height * 0.16,
            left: 16,
            right: 16,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 79, 79, 79).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(1.5, 1.5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Registered Professionals',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 8, 66, 114),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  QuickActionItem(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[50],
              child: Icon(icon, size: 30, color: Colors.blue[900]),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
