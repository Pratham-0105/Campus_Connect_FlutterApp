import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MentorshipRequestSheet extends StatefulWidget {

  final String alumniId;
  final String name;
  final String company;
  final String role;

  const MentorshipRequestSheet({
    super.key,
    required this.alumniId,
    required this.name,
    required this.company,
    required this.role,
  });

  @override
  State<MentorshipRequestSheet> createState() =>
      _MentorshipRequestSheetState();
}

class _MentorshipRequestSheetState
    extends State<MentorshipRequestSheet> {

  String selectedType = "Video Call";

  DateTime? selectedDateTime;

  final messageController = TextEditingController();

  /// PICK DATE & TIME
  Future pickDateTime() async {

    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  /// SEND REQUEST
  Future sendRequest() async {

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    /// get student name
    final studentDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    final studentName = studentDoc["name"];

    await FirebaseFirestore.instance
        .collection("mentorship_requests")
        .add({

      "studentId": user.uid,
      "studentName": studentName,
      "studentEmail": user.email,

      "alumniId": widget.alumniId,
      "alumniName": widget.name,
      "company": widget.company,
      "role": widget.role,

      "connectionType": selectedType,

      "message": messageController.text,

      "preferredTime": selectedDateTime,

      "status": "pending",

      "createdAt": FieldValue.serverTimestamp(),

    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Request Sent Successfully"),
      ),
    );
  }

  Widget connectionButton(String title, IconData icon) {

    bool isSelected = selectedType == title;

    return Expanded(
      child: GestureDetector(

        onTap: () {
          setState(() {
            selectedType = title;
          });
        },

        child: Container(

          padding: const EdgeInsets.symmetric(vertical: 14),

          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xff0A1B3D)
                : Colors.white,

            borderRadius: BorderRadius.circular(12),

            border: Border.all(color: Colors.grey.shade300),
          ),

          child: Column(
            children: [

              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
              ),

              const SizedBox(height: 5),

              Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.black,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),

      child: Container(

        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// HEADER
            Row(
              children: [

                const Text(
                  "Request Mentorship",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )

              ],
            ),

            const SizedBox(height: 15),

            /// ALUMNI INFO
            Row(
              children: [

                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),

                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                        "${widget.company} - ${widget.role}")

                  ],
                )

              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Connection Type",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                connectionButton(
                    "Video Call", Icons.videocam),

                const SizedBox(width: 10),

                connectionButton(
                    "Chat", Icons.chat),

                const SizedBox(width: 10),

                connectionButton(
                    "In-Person", Icons.phone),

              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Your Message",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: messageController,
              maxLines: 3,

              decoration: InputDecoration(
                hintText:
                "Tell the alumni why you'd like mentorship",
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Preferred Time",
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            GestureDetector(

              onTap: pickDateTime,

              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15),

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius:
                  BorderRadius.circular(12),
                ),

                child: Row(
                  children: [

                    Text(
                      selectedDateTime == null
                          ? "Select Date & Time"
                          : selectedDateTime
                          .toString(),
                    ),

                    const Spacer(),

                    const Icon(
                        Icons.calendar_today)

                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(

                    style: ElevatedButton
                        .styleFrom(
                      backgroundColor:
                      const Color(0xff0A1B3D),
                    ),

                    onPressed: sendRequest,

                    child:
                    const Text("Send Request"),
                  ),
                )

              ],
            ),

            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}