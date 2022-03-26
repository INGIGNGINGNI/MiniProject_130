import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/components/diseasetype.dart';
import 'package:mpj_disease_plant/pages/addData.dart';

class AddDisease extends StatefulWidget {
  const AddDisease({Key? key}) : super(key: key);

  @override
  State<AddDisease> createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  final _addFormKey = GlobalKey<FormState>();

  TextEditingController dis_name = TextEditingController();
  TextEditingController dis_symptom = TextEditingController();
  TextEditingController dis_treat = TextEditingController();
  TextEditingController dis_type = TextEditingController();

  List<ListDisType> dropdownItems = ListDisType.getListDisType();
  late List<DropdownMenuItem<ListDisType>> dropdownMenuItems;
  late ListDisType _selectedType;

  CollectionReference diseases =
      FirebaseFirestore.instance.collection('Diseases');
  Future<void> AddDiseases() {
    return diseases.add({
      'dis_name': dis_name.text,
      'dis_symptom': dis_symptom.text,
      'dis_treat': dis_treat.text,
      'dis_type': _selectedType.value,
    }).then((value) {
      print("Product data has been successfully");
      var route = MaterialPageRoute(
        builder: (context) => const AddData(),
      );
      Navigator.push(context, route);
    }).catchError((error) => print("Failed to add data: $error"));
  }

  @override
  void initState() {
    super.initState();
    dropdownMenuItems = createDropdownMenu(dropdownItems);
    _selectedType = dropdownMenuItems[0].value!;
  }

  List<DropdownMenuItem<ListDisType>> createDropdownMenu(
      List<ListDisType> dropdownItems) {
    List<DropdownMenuItem<ListDisType>> items = [];

    for (var item in dropdownItems) {
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item,
      ));
    }
    return items;
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
              formfield(context),
            ],
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
                key: _addFormKey,
                children: [
                  TextFormField(
                    controller: dis_name,
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
                    controller: dis_symptom,
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
                    controller: dis_treat,
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
                  Container(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          'บริเวณที่เกิด',
                          style: TextStyle(fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      value: _selectedType,
                      items: dropdownMenuItems,
                      isExpanded: true,
                      iconSize: 20,
                      iconEnabledColor:
                          const Color.fromARGB(255, 107, 196, 113),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value as ListDisType;
                        });
                      },
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
                              AddDiseases();
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
      title: const Text('เพิ่มข้อมูลโรคในไม้ประดับ'),
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
