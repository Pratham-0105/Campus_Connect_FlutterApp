import 'package:flutter/material.dart';

class AIInterviewPage extends StatefulWidget {
  const AIInterviewPage({super.key});

  @override
  State<AIInterviewPage> createState() => _AIInterviewPageState();
}

class _AIInterviewPageState extends State<AIInterviewPage> {

  int currentQuestion = 0;

  List<Map<String, dynamic>> questions = [

    {
      "question": "Explain the difference between var, let and const in JavaScript?",
      "answer": ""
    },

    {
      "question": "What is React Virtual DOM?",
      "answer": ""
    },

    {
      "question": "Explain async / await in JavaScript.",
      "answer": ""
    },

    {
      "question": "What is REST API?",
      "answer": ""
    }

  ];

  void nextQuestion() {

    if(currentQuestion < questions.length - 1){
      setState(() {
        currentQuestion++;
      });
    }else{
      showResult();
    }

  }

  void showResult(){

    showDialog(
      context: context,
      builder: (_) => AlertDialog(

        title: const Text("Interview Completed"),

        content: const Text(
            "Great job! Your answers have been submitted."),

        actions: [

          TextButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Finish"),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final question = questions[currentQuestion];

    return Scaffold(

      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        title: const Text("AI Interview"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Question ${currentQuestion + 1}/${questions.length}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Text(
                question["question"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Your Answer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              maxLines: 6,

              decoration: InputDecoration(
                hintText: "Type your answer here...",
                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onChanged: (value){
                questions[currentQuestion]["answer"] = value;
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6A11CB),
                  padding: const EdgeInsets.all(16),
                ),

                onPressed: nextQuestion,

                child: Text(
                  currentQuestion == questions.length - 1
                      ? "Finish Interview"
                      : "Next Question",
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}