import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlumniDashboard extends StatefulWidget {
  const AlumniDashboard({super.key});

  @override
  State<AlumniDashboard> createState() => _AlumniDashboardState();
}

class _AlumniDashboardState extends State<AlumniDashboard> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final pages = [
      const AlumniHomePage(),
      const RequestsPage(),
      const AlumniProfilePage(),
    ];

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xffFF8500),
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
              icon: Icon(Icons.notifications),
              label: "Requests"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}



/// HOME PAGE

class AlumniHomePage extends StatelessWidget {
  const AlumniHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        backgroundColor: const Color(0xffFF8500),
        title: const Text("Alumni Dashboard"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Welcome Alumni 🎓",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffFF8500),
                    Color(0xffFFB347),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Mentorship Requests",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Students are requesting mentorship from you.",
                    style: TextStyle(
                        color: Colors.white70),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Tips",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.school),
              title: Text("Guide students for interview preparation"),
            ),

            const ListTile(
              leading: Icon(Icons.work),
              title: Text("Share industry experience"),
            ),

            const ListTile(
              leading: Icon(Icons.people),
              title: Text("Build your alumni network"),
            ),

          ],
        ),
      ),
    );
  }
}



/// REQUESTS PAGE

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  Future acceptRequest(String id) async {

    await FirebaseFirestore.instance
        .collection("mentorship_requests")
        .doc(id)
        .update({
      "status": "accepted"
    });

  }

  Future rejectRequest(String id) async {

    await FirebaseFirestore.instance
        .collection("mentorship_requests")
        .doc(id)
        .update({
      "status": "rejected"
    });

  }

  @override
  Widget build(BuildContext context) {

    final alumniId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xffFF8500),
        title: const Text("Mentorship Requests"),
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection("mentorship_requests")
            .where("alumniId", isEqualTo: alumniId)
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final requests = snapshot.data!.docs;

          if (requests.isEmpty) {
            return const Center(
              child: Text("No Requests"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,

            itemBuilder: (context, index) {

              final data = requests[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5)
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      data["studentName"] ?? "",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 6),

                    Text(data["message"] ?? ""),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            acceptRequest(data.id);
                          },
                          child: const Text("Accept"),
                        ),

                        const SizedBox(width: 10),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            rejectRequest(data.id);
                          },
                          child: const Text("Reject"),
                        ),

                      ],
                    )

                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}



/// PROFILE PAGE

class AlumniProfilePage extends StatelessWidget {
  const AlumniProfilePage({super.key});

  Future<Map<String, dynamic>?> getAlumniData() async {

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

      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: const Color(0xffFF8500),
      ),

      body: FutureBuilder(

        future: getAlumniData(),

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
                  NetworkImage("https://i.pravatar.cc/150"),
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
                profileTile("Passout Year", data["passoutYear"] ?? ""),

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