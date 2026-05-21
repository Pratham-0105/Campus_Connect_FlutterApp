import 'package:flutter/material.dart';

import 'student_login_screen.dart';
import 'student_signup_screen.dart';
import 'alumni_login_screen.dart';
import 'alumni_signup_screen.dart';
import 'admin_login_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  final bool isLogin;

  const RoleSelectionScreen({super.key, required this.isLogin});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {

  Widget roleCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {

        if (title == "Student") {

          if (widget.isLogin) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentLoginScreen(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentSignupScreen(),
              ),
            );
          }

        }

        if (title == "Alumni") {

          if (widget.isLogin) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AlumniLoginScreen(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AlumniSignupScreen(),
              ),
            );
          }

        }

        if (title == "Admin") {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminLoginScreen(),
            ),
          );

        }

      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),

        child: Row(
          children: [

            Container(
              height: 60,
              width: 60,

              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),

            const SizedBox(width: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            const Icon(Icons.arrow_forward_ios, size: 18),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.isLogin ? "Login As" : "Signup As",
        ),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            roleCard(
              title: "Student",
              icon: Icons.school,
              color: const Color(0xff6A11CB),
            ),

            roleCard(
              title: "Alumni",
              icon: Icons.people,
              color: const Color(0xffFF8500),
            ),

            // Admin only visible in LOGIN
            if (widget.isLogin)
              roleCard(
                title: "Admin",
                icon: Icons.admin_panel_settings,
                color: const Color(0xff3A86FF),
              ),

          ],
        ),
      ),
    );
  }
}