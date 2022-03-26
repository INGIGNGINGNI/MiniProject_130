import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPlant extends StatefulWidget {
  const EditPlant({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<EditPlant> createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  final _editFormKey = GlobalKey<FormState>();
  final TextEditingController _plantname = TextEditingController();
  final TextEditingController _plantpros = TextEditingController();
  final TextEditingController _plantuse = TextEditingController();
  final TextEditingController _planttype = TextEditingController();

  CollectionReference plants = FirebaseFirestore.instance.collection('Plants');
  Future<void> updatePlant() {
    return plants.doc(widget.id).update({
      'plant_name': _plantname.text,
      'plant_pros': _plantpros.text,
      'plant_use': _plantuse.text,
      'plant_type': _planttype.text,
    }).then((value) {
      print("Data updated successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to update user: $error"));
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
    return FutureBuilder<DocumentSnapshot>(
      future: plants.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _plantname.text = data['plant_name'];
          _plantpros.text = data['plant_pros'];
          _plantuse.text = data['plant_use'];
          _planttype.text = data['plant_type'];

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
                                  onPressed: updatePlant,
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
        return const Text('Loading');
      },
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
}
