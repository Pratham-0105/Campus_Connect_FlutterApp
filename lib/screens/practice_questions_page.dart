import 'package:flutter/material.dart';

class PracticeQuestionsPage extends StatelessWidget {

  final String title;
  final List<String> questions;

  const PracticeQuestionsPage({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xff6A11CB),
      ),

      backgroundColor: const Color(0xffF6F4FF),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: questions.length,

        itemBuilder: (context,index){

          return Container(

            margin: const EdgeInsets.only(bottom:16),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12,blurRadius:6)
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Question ${index + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height:10),

                Text(
                  questions[index],
                  style: const TextStyle(fontSize:16),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}