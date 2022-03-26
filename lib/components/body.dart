import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpj_disease_plant/components/diseasePlantCard.dart';
import 'package:mpj_disease_plant/components/plantscard.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          header(size, context),
          titlePlant(),
          const PlantCard(),
          titleGroup(),
          const DiseasePlantCard(),
        ],
      ),
    );
  }

  Padding titleGroup() {
    return const Padding(
      padding: EdgeInsets.only(right: 210, bottom: 5),
      child: Text(
        'บริเวณที่เกิดโรค',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 107, 196, 113)),
      ),
    );
  }

  Padding titlePlant() {
    return const Padding(
      padding: EdgeInsets.only(right: 220, bottom: 10),
      child: Text(
        'ต้นไม้ยอดนิยม',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 107, 196, 113)),
      ),
    );
  }

  Container header(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20 * 2.5),
      height: size.height * 0.225,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 56),
            height: size.height * 0.2,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                // image: AssetImage('assets/images/bg_home3.jpg'),
                image: AssetImage('assets/images/login_bg.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Plant Disease',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Color.fromARGB(255, 68, 134, 73),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                // Image.asset('assets/images/logo.png'),
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/logopage.jpg'),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.5),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    child: TextField(
                      onChanged: ((value) {}),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle:
                            TextStyle(color: Colors.green.withOpacity(0.5)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset('assets/icons/search.svg'),
                  ),
                ],
              ),
            ),
          ),
          // showList(context),
        ],
      ),
    );
  }
}
