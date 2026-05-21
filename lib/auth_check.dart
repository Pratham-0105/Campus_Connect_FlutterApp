import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/screens/welcome_screen.dart';
import 'dashboards/student_dashboard.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading while checking auth status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is logged in, show the dashboard
        // Note: Future updates should check Firestore for the user's role
        // to return the correct Dashboard (Student/Alumni/Admin).
        if (snapshot.hasData) {
          return const StudentDashboard();
        }

        // If not logged in, show welcome screen
        return const WelcomeScreen();
      },
    );
  }
}