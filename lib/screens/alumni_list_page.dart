import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../mentorship_request_sheet.dart';

class AlumniListPage extends StatefulWidget {
  const AlumniListPage({super.key});

  @override
  State<AlumniListPage> createState() => _AlumniListPageState();
}

class _AlumniListPageState extends State<AlumniListPage> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F4FF),

      appBar: AppBar(
        title: const Text("Connect Alumni"),
        backgroundColor: const Color(0xff6A11CB),
      ),

      body: Column(
        children: [

          /// SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              decoration: InputDecoration(
                hintText: "Search alumni...",
                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),

          /// ALUMNI LIST
          Expanded(
            child: StreamBuilder(

              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("userType", isEqualTo: "alumni")
                  .snapshots(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final alumniList = snapshot.data!.docs;

                if (alumniList.isEmpty) {
                  return const Center(
                    child: Text("No alumni available"),
                  );
                }

                return ListView.builder(

                  padding: const EdgeInsets.all(16),

                  itemCount: alumniList.length,

                  itemBuilder: (context, index) {

                    final alumni = alumniList[index];

                    /// SAFE DATA ACCESS
                    final data = alumni.data() as Map<String, dynamic>;

                    final name = data["name"] ?? "Unknown Alumni";
                    final company = data["company"] ?? "Company not added";
                    final role = data["role"] ?? "Role not added";

                    /// SEARCH FILTER
                    if (searchText.isNotEmpty &&
                        !name.toLowerCase().contains(searchText)) {
                      return const SizedBox();
                    }

                    return Container(

                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),

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

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(
                            children: [

                              const CircleAvatar(
                                radius: 25,
                                child: Icon(Icons.person),
                              ),

                              const SizedBox(width: 12),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    company,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),

                                ],
                              ),

                              const Spacer(),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: const Text(
                                  "Verified",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )

                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(role),

                          const SizedBox(height: 14),

                          /// CONNECT BUTTON
                          SizedBox(
                            width: double.infinity,

                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff6A11CB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),

                              onPressed: () {

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,

                                  builder: (_) => MentorshipRequestSheet(
                                    alumniId: alumni.id,
                                    name: name,
                                    company: company,
                                    role: role,
                                  ),
                                );

                              },

                              child: const Text("Connect"),
                            ),
                          )

                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}