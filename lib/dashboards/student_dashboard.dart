import 'package:campus_connect/screens/mock_interview_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/ai_interview_page.dart';
import '../screens/alumni_list_page.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final pages = [
      const HomePage(),
      const PracticePage(),
      const ProfilePage(),
    ];

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xff6A11CB),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.psychology),
              label: "Practice"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}






class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget statCard(String title,String value,IconData icon){

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff6A11CB),Color(0xffC77DFF)],
          ),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          children: [

            Icon(icon,color: Colors.white),

            const SizedBox(height:10),

            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),

            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12))
          ],
        ),
      ),
    );
  }

  Widget skill(String name,double value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(name),

        const SizedBox(height:6),

        LinearProgressIndicator(
          value: value,
          minHeight:8,
          backgroundColor: Colors.grey.shade300,
          color: Colors.green,
        ),

        const SizedBox(height:10)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        backgroundColor: const Color(0xff6A11CB),
        title: const Text("Student Dashboard"),
        actions: const [

          Padding(
            padding: EdgeInsets.only(right:12),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=3"),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Welcome back 👋",
              style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height:20),

            Row(
              children: [
                statCard("Interviews","12",Icons.record_voice_over),
                statCard("Avg Score","78%",Icons.bar_chart),
                statCard("Upcoming","3",Icons.calendar_today),
              ],
            ),

            const SizedBox(height:20),

            const Text(
              "Interview Practice",
              style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height:10),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff6A11CB),Color(0xff9D4EDD)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    "AI Powered Interview Practice",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height:10),

                  const Text(
                    "Practice real interview scenarios with AI interviewer",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height:12),

                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                    ),

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AIInterviewPage(),
                        ),
                      );

                    },

                    child: const Text("Start AI Interview"),
                  )

                ],
              ),
            ),

            const SizedBox(height:20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black),
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AlumniListPage(),
                        ),
                      );

                    },
                    child: const Text("Connect Alumni"),
                  ),
                ),

                const SizedBox(width:10),

                Expanded(
                  child: OutlinedButton(

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MockInterviewPage(),
                        ),
                      );

                    },

                    child: const Text("Mock Interview"),
                  ),
                ),

              ],
            ),

            const SizedBox(height:20),

            const Text(
              "Skill Assessment",
              style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height:10),

            skill("JavaScript",0.85),
            skill("React",0.78),
            skill("Node.js",0.72),
            skill("Python",0.65),

            const SizedBox(height:80),

          ],
        ),
      ),
    );
  }
}






class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  Widget practiceCard(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      Color color) {

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
                      fontSize: 16),
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

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$title Started")),
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
        title: const Text("Practice"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Practice Center",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            practiceCard(
              context,
              "Interview Questions",
              "Practice common interview questions",
              Icons.question_answer,
              Colors.blue,
            ),

            practiceCard(
              context,
              "Coding Problems",
              "Solve coding interview problems",
              Icons.code,
              Colors.green,
            ),

            practiceCard(
              context,
              "System Design",
              "Practice system design interviews",
              Icons.architecture,
              Colors.orange,
            ),

            practiceCard(
              context,
              "Behavioral Questions",
              "HR and leadership questions",
              Icons.people,
              Colors.purple,
            ),

          ],
        ),
      ),
    );
  }
}





class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>?> getStudentData() async {

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    return doc.data();
  }

  Future logout(BuildContext context) async {

    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Widget profileTile(String title, String value) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5)
        ],
      ),

      child: Row(
        children: [

          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold),
          ),

          const Spacer(),

          Text(value)

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: FutureBuilder(

        future: getStudentData(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),

            child: Column(

              children: [

                const CircleAvatar(
                  radius: 45,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=5"),
                ),

                const SizedBox(height: 10),

                Text(
                  data["name"] ?? "",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                profileTile("Email", data["email"] ?? ""),
                profileTile("College", data["college"] ?? ""),
                profileTile("Department", data["department"] ?? ""),
                profileTile("Role", data["role"] ?? ""),
                profileTile("Year", data["year"] ?? ""),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),

                    onPressed: () {
                      logout(context);
                    },

                    child: const Text("Logout"),
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}