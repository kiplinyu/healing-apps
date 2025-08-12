import 'package:flutter/material.dart';

class AppbarDashboard extends StatelessWidget {
  const AppbarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            const SizedBox(width: 8),
            const Text(
              'Leonardo',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              const Icon(
                Icons.notifications_none,
                size: 28,
                color: Colors.black,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
