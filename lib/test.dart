import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class plantcard extends StatefulWidget {
  const plantcard({Key? key}) : super(key: key);

  @override
  State<plantcard> createState() => _plantcardState();
}

class _plantcardState extends State<plantcard> {
  List<Color> colors = [Colors.green, Colors.orange.shade400];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: showList(),
    );
  }

  Widget showList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Plants').snapshots(),
      builder: (context, snapshot) {
        List<Widget> homelist = [];
        if (snapshot.hasData) {
          var plants = snapshot.data;
          homelist = [
            Row(
              children: plants!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return Container(
                  height: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 220,
                        height: 100,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/image_1.png',
                              height: 200,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'ยางอินเดีย',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                const Text(
                                  'ไม้ฟอกอากาศ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 4),
                                  child: Text(
                                    'ดูเพิ่มเติม',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: colors[index],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ];
        }
        return Center(
          child: Column(
            children: homelist,
          ),
        );
      },
    );
  }
}
