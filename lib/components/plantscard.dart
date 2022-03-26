import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/pages/detailPlant.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({Key? key}) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  // List<Color> colors = [Colors.green, Colors.orange.shade400];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: showPlantsList(),
    );
  }

  Widget showPlantsList() {
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
                  margin: const EdgeInsets.only(
                      left: 20, top: 5 / 2, bottom: 20 * 2.5),
                  child: Column(
                    children: [
                      Image.asset('assets/images/image_1.png'),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPlant(id: doc.id),
                              ));
                        },
                        child: Container(
                          width: 160,
                          height: 50,
                          padding: const EdgeInsets.all(20 / 2),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 50,
                                  color: Colors.green.withOpacity(0.20))
                            ],
                          ),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${data['plant_name']}\n',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
