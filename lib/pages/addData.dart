import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpj_disease_plant/components/auth.dart';
import 'package:mpj_disease_plant/pages/addDisease.dart';
import 'package:mpj_disease_plant/pages/addPlant.dart';
import 'package:mpj_disease_plant/pages/showAllData.dart';

import 'login.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
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
              bottonAdd(),
            ],
          ),
        ),
        bottomNavigationBar: navbar(),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowAllData(),
                ),
              );
            },
            icon: SvgPicture.asset('assets/icons/menu-burger.svg'),
          ),
          IconButton(
            onPressed: () {},
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

  Padding bottonAdd() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 200),
            child: Text(
              'จัดการข้อมูล',
              style: TextStyle(
                color: Color.fromARGB(255, 107, 196, 113),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPlant(),
                      ),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 150,
                    decoration: const BoxDecoration(
                      // color: Color.fromARGB(255, 107, 196, 113),
                      image: DecorationImage(
                        image: AssetImage('assets/images/header-bg.jpg'),
                        fit: BoxFit.fill,
                        opacity: 50,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 120, left: 20),
                child: Text(
                  'เพิ่มข้อมูลไม้ประดับ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDisease(),
                      ),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 150,
                    decoration: const BoxDecoration(
                      // color: Color.fromARGB(255, 107, 196, 113),
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg_box5.jpg'),
                          fit: BoxFit.cover,
                          opacity: 50),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 120, left: 20),
                child: Text(
                  'เพิ่มข้อมูลโรคในไม้ประดับ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
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
