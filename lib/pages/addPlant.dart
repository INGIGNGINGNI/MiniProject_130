import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/pages/addData.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final _addFormKey = GlobalKey<FormState>();

  TextEditingController _plantname = TextEditingController();
  TextEditingController _plantpros = TextEditingController();
  TextEditingController _plantuse = TextEditingController();
  TextEditingController _planttype = TextEditingController();

  CollectionReference plants = FirebaseFirestore.instance.collection('Plants');
  Future<void> AddPlants() {
    return plants.add({
      'plant_name': _plantname.text,
      'plant_pros': _plantpros.text,
      'plant_use': _plantuse.text,
      'plant_type': _planttype.text,
    }).then((value) {
      print("Product data has been successfully");
      var route = MaterialPageRoute(
        builder: (context) => const AddData(),
      );
      Navigator.push(context, route);
    }).catchError((error) => print("Failed to add data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      child: Scaffold(
        appBar: appBar(),
        body: Form(
          key: _addFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(size, context),
                formfield(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView formfield(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [
                  TextFormField(
                    controller: _plantname,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'กรุณาป้อนข้อมูล';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      label: const Text(
                        'ชื่อของต้นไม้',
                        style: TextStyle(fontSize: 20),
                      ),
                      // prefixIcon: const Icon(Icons.nature_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _plantpros,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'กรุณาป้อนข้อมูล';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text(
                        'ลักษณะเด่นของต้นไม้',
                        style: TextStyle(fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _plantuse,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'กรุณาป้อนข้อมูล';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      label: const Text(
                        'ประโยชน์ของต้นไม้',
                        style: TextStyle(fontSize: 20),
                      ),
                      // prefixIcon: const Icon(Icons.nature_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _planttype,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'กรุณาป้อนข้อมูล';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      label: const Text(
                        'ประเภทของต้นไม้',
                        style: TextStyle(fontSize: 20),
                      ),
                      // prefixIcon: const Icon(Icons.nature_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'บันทึกข้อมูล',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 107, 196, 113),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            const Color.fromARGB(255, 107, 196, 113),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              AddPlants();
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      title: const Text('เพิ่มข้อมูลไม้ประดับ'),
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
            height: size.height * 0.4,
            decoration: const BoxDecoration(
              // color: Color.fromARGB(255, 107, 196, 113),
              image: DecorationImage(
                image: AssetImage('assets/images/header-bg.jpg'),
                fit: BoxFit.fill,
                opacity: 80,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
