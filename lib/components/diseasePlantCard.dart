import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/pages/diseaseLeaf.dart';
import 'package:mpj_disease_plant/pages/diseaseRoot.dart';

class DiseasePlantCard extends StatefulWidget {
  const DiseasePlantCard({Key? key}) : super(key: key);

  @override
  State<DiseasePlantCard> createState() => _DiseasePlantCardState();
}

class _DiseasePlantCardState extends State<DiseasePlantCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          showDiseaseDetail(
            images: 'assets/images/bg_box7.png',
            type: 'โรคที่เกิดบริเวณใบ',
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiseaseLeafPlant()));
            },
          ),
          showDiseaseDetail(
            images: 'assets/images/bg_box6.jpg',
            type: 'โรคที่เกิดบริเวณราก',
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiseaseRootPlant()));
            },
          ),
        ],
      ),
    );
  }
}

class showDiseaseDetail extends StatelessWidget {
  const showDiseaseDetail({
    Key? key,
    this.type,
    this.images,
    this.ontap,
  }) : super(key: key);
  final String? type;
  final String? images;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return diseaseCard(context, size);
  }

  Widget diseaseCard(BuildContext context, Size size) {
    return Stack(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            width: size.width * 0.8,
            margin:
                const EdgeInsets.only(left: 20, top: 20 / 2, bottom: 20 / 2),
            height: 185,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(images!),
                opacity: 40,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 150, 50, 0),
          child: Text(
            type!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
