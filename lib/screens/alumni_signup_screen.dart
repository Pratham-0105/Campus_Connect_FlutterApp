import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dashboards/alumni_dashboard.dart';

class AlumniSignupScreen extends StatefulWidget {
  const AlumniSignupScreen({super.key});

  @override
  State<AlumniSignupScreen> createState() => _AlumniSignupScreenState();
}

class _AlumniSignupScreenState extends State<AlumniSignupScreen> {

  bool hidePassword = true;

  String selectedRole = "Frontend Engineer";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final collegeController = TextEditingController();
  final departmentController = TextEditingController();
  final passoutController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signupAlumni() async {

    try {

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({

        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "college": collegeController.text.trim(),
        "department": departmentController.text.trim(),
        "role": selectedRole,
        "passoutYear": passoutController.text.trim(),

        "userType": "alumni",

        "createdAt": Timestamp.now()

      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AlumniDashboard(),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        title: const Text("Alumni Signup"),
        backgroundColor: const Color(0xffFF8500),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Full Name",
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: collegeController,
              decoration: InputDecoration(
                hintText: "College Name",
                prefixIcon: const Icon(Icons.school),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: departmentController,
              decoration: InputDecoration(
                hintText: "Department",
                prefixIcon: const Icon(Icons.account_tree),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: InputDecoration(
                hintText: "Current Role",
                prefixIcon: const Icon(Icons.work),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: [
                "Frontend Engineer",
                "Backend Engineer",
                "ML Engineer",
              ].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passoutController,
              decoration: InputDecoration(
                hintText: "Passout Year",
                prefixIcon: const Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            GestureDetector(

              onTap: signupAlumni,

              child: Container(
                width: double.infinity,
                height: 55,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffFF8500),
                      Color(0xffFFB347),
                    ],
                  ),
                ),

                child: const Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(
                  color: Color(0xffFF8500),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}