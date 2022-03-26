import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditDisease extends StatefulWidget {
  const EditDisease({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<EditDisease> createState() => _EditDiseaseState();
}

class _EditDiseaseState extends State<EditDisease> {
  final _editFormKey = GlobalKey<FormState>();
  final TextEditingController _disname = TextEditingController();
  final TextEditingController _dissymptom = TextEditingController();
  final TextEditingController _distreat = TextEditingController();
  final TextEditingController _distype = TextEditingController();

  CollectionReference diseases =
      FirebaseFirestore.instance.collection('Diseases');
  Future<void> updatePlant() {
    return diseases.doc(widget.id).update({
      'dis_name': _disname.text,
      'dis_symptom': _dissymptom.text,
      'dis_treat': _distreat.text,
      'dis_type': _distype.text,
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
      future: diseases.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _disname.text = data['dis_name'];
          _dissymptom.text = data['dis_symptom'];
          _distreat.text = data['dis_treat'];
          _distype.text = data['dis_type'];

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
                          controller: _disname,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            label: const Text(
                              'ชื่อของโรค',
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
                          controller: _dissymptom,
                          decoration: InputDecoration(
                            label: const Text(
                              'อาการของโรค',
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
                          controller: _distreat,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            label: const Text(
                              'การป้องกัน/การรักษา',
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
                          controller: _distype,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            label: const Text(
                              'บริเวณที่เกิด',
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
      title: const Text('แก้ไขข้อมูลโรคในไม้ประดับ'),
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
                image: AssetImage('assets/images/bg_box5.jpg'),
                fit: BoxFit.cover,
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
