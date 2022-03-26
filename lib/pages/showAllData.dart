import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpj_disease_plant/components/auth.dart';
import 'package:mpj_disease_plant/pages/editDisease.dart';
import 'package:mpj_disease_plant/pages/editPlant.dart';
import 'package:mpj_disease_plant/pages/login.dart';

class ShowAllData extends StatefulWidget {
  const ShowAllData({Key? key}) : super(key: key);

  @override
  State<ShowAllData> createState() => _ShowAllDataState();
}

class _ShowAllDataState extends State<ShowAllData> {
  CollectionReference plants = FirebaseFirestore.instance.collection('Plants');

  Future<void> deletePlant({String? id}) {
    return plants.doc(id).delete().then((value) {
      print("Deleted data Successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to delete user: $error"));
  }

  CollectionReference diseases =
      FirebaseFirestore.instance.collection('Diseases');

  Future<void> deleteDisease({String? id}) {
    return diseases.doc(id).delete().then((value) {
      print("Deleted data Successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(size, context),
              titlePlant(),
              showPlant(),
              titleDisease(),
              showDisease(),
            ],
          ),
        ),
        bottomNavigationBar: navbar(),
      ),
    );
  }

  Widget showDisease() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Diseases').snapshots(),
      builder: (context, snapshot) {
        List<Widget> diseaselist = [];
        if (snapshot.hasData) {
          var diseases = snapshot.data;
          diseaselist = [
            Column(
              children: diseases!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDisease(id: doc.id),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 107, 196, 113),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/bg_box5.jpg'),
                                fit: BoxFit.cover,
                                opacity: 100,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(10, 3),
                                    blurRadius: 10,
                                    color: Colors.green.withOpacity(0.3))
                              ]),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 40),
                          child: Text(
                            '${data['dis_name']}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, right: 20),
                          child: IconButton(
                            onPressed: () {
                              var alertDialog = AlertDialog(
                                title: const Text(
                                    'ยืนยันการลบข้อมูลโรคในไม้ประดับ'),
                                content: Text(
                                    'คุณต้องการลบ ${data['dis_name']} ใช่หรือไม่'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ยกเลิก')),
                                  TextButton(
                                      onPressed: () {
                                        deleteDisease(id: doc.id);
                                      },
                                      child: const Text(
                                        'ยืนยัน',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => alertDialog,
                              );
                            },
                            icon: const Icon(Icons.delete_forever),
                            color: Colors.white,
                            iconSize: 30,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ];
        }
        return Center(
          child: Column(
            children: diseaselist,
          ),
        );
      },
    );
  }

  Widget showPlant() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Plants').snapshots(),
      builder: (context, snapshot) {
        List<Widget> plantlist = [];
        if (snapshot.hasData) {
          var plants = snapshot.data;
          plantlist = [
            Column(
              children: plants!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPlant(id: doc.id),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EditPlant(id: doc.id),
                          //   ),
                          // ).then((value) => setState(() {}));
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 107, 196, 113),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/header-bg.jpg'),
                                fit: BoxFit.fill,
                                opacity: 100,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(10, 3),
                                    blurRadius: 10,
                                    color: Colors.green.withOpacity(0.3))
                              ]),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 40),
                          child: Text(
                            '${data['plant_name']}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, right: 20),
                          child: IconButton(
                            onPressed: () {
                              var alertDialog = AlertDialog(
                                title: const Text('ยืนยันการลบข้อมูลไม้ประดับ'),
                                content: Text(
                                    'คุณต้องการลบ ${data['plant_name']} ใช่หรือไม่'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ยกเลิก')),
                                  TextButton(
                                      onPressed: () {
                                        deletePlant(id: doc.id);
                                      },
                                      child: const Text(
                                        'ยืนยัน',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => alertDialog,
                              );
                            },
                            icon: const Icon(Icons.delete_forever),
                            color: Colors.white,
                            iconSize: 30,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ];
        }
        return Center(
          child: Column(
            children: plantlist,
          ),
        );
      },
    );
  }

  Padding titleDisease() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 60),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(right: 130),
            child: Text(
              'ข้อมูลโรคในไม้ประดับ',
              style: TextStyle(
                color: Color.fromARGB(255, 107, 196, 113),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding titlePlant() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(right: 130),
            child: Text(
              'ข้อมูลรายชื่อไม้ประดับ',
              style: TextStyle(
                color: Color.fromARGB(255, 107, 196, 113),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navbar() {
    return Container(
      padding: const EdgeInsets.only(left: 20 * 2, right: 20 * 2),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 30,
            color: Colors.green.withOpacity(0.35),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/menu-burger.svg'),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/home.svg'),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/heart.svg'),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/menu.svg'),
        onPressed: () {},
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/sign-out.svg',
                color: Colors.white,
              ),
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Container header(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10 * 2.5),
      height: size.height * 0.225,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 56),
            height: size.height * 0.2,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 107, 196, 113),
              // image: DecorationImage(
              //   image: AssetImage('assets/images/bg_home3.jpg'),
              //   fit: BoxFit.cover,
              // ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'ยินดีต้อนรับ\nAdmin อิงกมล พูลนวล',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/logopage.jpg'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
