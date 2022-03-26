import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/pages/detailDisease.dart';

class DiseaseRootPlant extends StatefulWidget {
  const DiseaseRootPlant({Key? key}) : super(key: key);

  @override
  State<DiseaseRootPlant> createState() => _DiseaseRootPlantState();
}

class _DiseaseRootPlantState extends State<DiseaseRootPlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: ListView(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg_box6.jpg'),
                        opacity: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.green.withOpacity(0.70),
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: showList(context),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 20, bottom: 20),
                        child: Text(
                          'โรคที่เกิดบริเวณราก',
                          style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 78, 151, 79),
                            // color: Color.fromARGB(255, 147, 194, 148),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Diseases')
            .where('dis_type', isEqualTo: 'ราก')
            .snapshots(),
        builder: (context, snapshot) {
          List<Widget> homelist = [];
          if (snapshot.hasData) {
            var diseases = snapshot.data;
            homelist = [
              Column(
                children: diseases!.docs.map((DocumentSnapshot doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/bottom_img_1.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(5, 10),
                                blurRadius: 10,
                                color: Colors.green.withOpacity(0.20),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailDisease(id: doc.id),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  '${data['dis_name']}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
        });
  }

  // Column showListss(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Padding(
  //         padding: EdgeInsets.only(top: 25, left: 30, bottom: 20),
  //         child: Text(
  //           'โรคที่เกิดจากใบ',
  //           style: TextStyle(
  //             fontSize: 26,
  //             color: Color.fromARGB(255, 78, 151, 79),
  //             // color: Color.fromARGB(255, 147, 194, 148),
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 30),
  //         child: Container(
  //           height: 140,
  //           decoration: BoxDecoration(
  //             image: const DecorationImage(
  //               image: AssetImage('assets/images/bottom_img_1.png'),
  //               fit: BoxFit.cover,
  //             ),
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(25),
  //               topRight: Radius.circular(25),
  //             ),
  //             boxShadow: [
  //               BoxShadow(
  //                 offset: const Offset(5, 10),
  //                 blurRadius: 10,
  //                 color: Colors.green.withOpacity(0.20),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {},
  //         child: Container(
  //           height: 40,
  //           margin: const EdgeInsets.symmetric(horizontal: 30),
  //           decoration: BoxDecoration(
  //             borderRadius: const BorderRadius.only(
  //               bottomLeft: Radius.circular(25),
  //               bottomRight: Radius.circular(25),
  //             ),
  //             color: Colors.white,
  //             boxShadow: [
  //               BoxShadow(
  //                   offset: const Offset(0, 10),
  //                   blurRadius: 50,
  //                   color: Colors.green.withOpacity(0.20))
  //             ],
  //           ),
  //           child: Row(
  //             children: [
  //               RichText(
  //                 text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       text: 'plant_name',
  //                       style: Theme.of(context).textTheme.button,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
