import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/pages/showAllData.dart';

class EditPlant extends StatefulWidget {
  const EditPlant({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<EditPlant> createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  CollectionReference plants = FirebaseFirestore.instance.collection("Plants");
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  final TextEditingController _plantname = TextEditingController();
  final TextEditingController _plantpros = TextEditingController();
  final TextEditingController _plantuse = TextEditingController();
  final TextEditingController _planttype = TextEditingController();

  @override
  void initState() {
    super.initState();
    getFirebaseData(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      child: Scaffold(
        appBar: appBar(),
        body: Form(
          key: _editFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(size, context),
                editformfield(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editformfield(BuildContext context) {
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
                        'บันทึกการแก้ไขข้อมูล',
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
                            if (_editFormKey.currentState!.validate()) {
                              plants.doc(widget.id).update({
                                'plant_name': _plantname.text,
                                'plant_pros': _plantpros.text,
                                'plant_use': _plantuse.text,
                                'plant_type': _planttype.text,
                              }).then((value) {
                                print("Data Update Successedfully");

                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ShowAllData(),
                                    ));
                              }).catchError((error) =>
                                  print("Failed to Update Item: $error"));
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ),
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
      title: const Text('แก้ไขข้อมูลไม้ประดับ'),
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

  getFirebaseData(String id) {
    FirebaseFirestore.instance.collection("Plants").doc(id).get().then((value) {
      setState(() {
        _plantname.text = value.data()?['plant_name'];
        _plantpros.text = value.data()?['plant_pros'];
        _plantuse.text = value.data()?['plant_use'];
        _planttype.text = value.data()?['plant_type'];
      });
    });
  }
}
