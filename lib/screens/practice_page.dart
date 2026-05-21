import 'package:flutter/material.dart';
import 'practice_questions_page.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  /// QUESTIONS

  final List<String> interviewQuestions = const [
    "Tell me about yourself.",
    "Why do you want to join our company?",
    "What are your strengths and weaknesses?",
    "Describe a challenging situation you handled.",
    "Where do you see yourself in 5 years?"
  ];

  final List<String> codingQuestions = const [
    "Write a program to reverse a string.",
    "Find the largest element in an array.",
    "Check if a number is prime.",
    "Write a program for Fibonacci series.",
    "Find duplicates in an array."
  ];

  final List<String> systemDesignQuestions = const [
    "Design a URL shortener like Bitly.",
    "Design a chat application.",
    "Design a scalable notification system.",
    "Design Instagram feed system.",
    "Design a ride-sharing system like Uber."
  ];

  final List<String> behavioralQuestions = const [
    "Describe a time you worked in a team.",
    "Tell me about a failure and what you learned.",
    "How do you handle conflict?",
    "Describe a leadership experience.",
    "How do you manage deadlines?"
  ];

  /// PRACTICE CARD WIDGET
  Widget practiceCard(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      Color color,
      List<String> questions,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6)
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

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
                  builder: (_) => PracticeQuestionsPage(
                    title: title,
                    questions: questions,
                  ),
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
        title: const Text("Practice Center"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Practice Center",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Improve your interview skills with daily practice",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            practiceCard(
              context,
              "Interview Questions",
              "Practice common interview questions",
              Icons.question_answer,
              Colors.blue,
              interviewQuestions,
            ),

            practiceCard(
              context,
              "Coding Problems",
              "Solve coding interview problems",
              Icons.code,
              Colors.green,
              codingQuestions,
            ),

            practiceCard(
              context,
              "System Design",
              "Practice system design interviews",
              Icons.architecture,
              Colors.orange,
              systemDesignQuestions,
            ),

            practiceCard(
              context,
              "Behavioral Questions",
              "HR and leadership interview questions",
              Icons.people,
              Colors.purple,
              behavioralQuestions,
            ),

          ],
        ),
      ),
    );
  }
}