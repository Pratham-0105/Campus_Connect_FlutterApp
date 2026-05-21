import 'package:flutter/material.dart';
import 'ai_interview_page.dart';

class MockInterviewPage extends StatelessWidget {
  const MockInterviewPage({super.key});

  Widget interviewCard(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      Color color) {

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          )
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: const TextStyle(color: Colors.grey),
                ),

              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff6A11CB),
            ),

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AIInterviewPage(),
                ),
              );

            },

            child: const Text("Start"),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        title: const Text("Mock Interviews"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Practice Interviews",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            interviewCard(
              context,
              "Frontend Interview",
              "React, JavaScript, UI concepts",
              Icons.web,
              Colors.blue,
            ),

            interviewCard(
              context,
              "Backend Interview",
              "Node.js, APIs, Databases",
              Icons.storage,
              Colors.green,
            ),

            interviewCard(
              context,
              "Machine Learning Interview",
              "ML concepts, Python, Models",
              Icons.psychology,
              Colors.orange,
            ),

          ],
        ),
      ),
    );
  }
}