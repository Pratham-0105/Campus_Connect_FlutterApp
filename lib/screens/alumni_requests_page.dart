import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlumniRequestsPage extends StatelessWidget {
  const AlumniRequestsPage({super.key});

  Future updateStatus(String id, String status) async {

    await FirebaseFirestore.instance
        .collection("mentorship_requests")
        .doc(id)
        .update({
      "status": status
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Mentorship Requests"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection("mentorship_requests")
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text("No Requests Yet"),
            );
          }

          return ListView.builder(

            itemCount: docs.length,

            itemBuilder: (context, index) {

              final data = docs[index].data();
              final id = docs[index].id;

              return Card(
                margin: const EdgeInsets.all(12),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        data["studentName"],
                        style: const TextStyle(
                            fontSize:18,
                            fontWeight: FontWeight.bold),
                      ),

                      Text(data["studentEmail"]),

                      const SizedBox(height:10),

                      Text("Connection: ${data["connectionType"]}"),

                      Text("Message: ${data["message"]}"),

                      Text("Preferred Time: ${data["preferredTime"]}"),

                      const SizedBox(height:10),

                      Row(
                        children: [

                          Expanded(
                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),

                              onPressed: () {
                                updateStatus(id, "accepted");
                              },

                              child: const Text("Accept"),
                            ),
                          ),

                          const SizedBox(width:10),

                          Expanded(
                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),

                              onPressed: () {
                                updateStatus(id, "rejected");
                              },

                              child: const Text("Reject"),
                            ),
                          )

                        ],
                      )

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}