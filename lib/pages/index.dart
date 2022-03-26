import 'package:flutter/material.dart';
import 'package:mpj_disease_plant/pages/homepage.dart';
import 'package:mpj_disease_plant/pages/login.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  get fontSize => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logopage.jpg'),
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            children: [
              menuHeader(),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Padding(padding: EdgeInsets.only(bottom: 500)),
              startbtn(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox startbtn() {
    return SizedBox(
      width: 200,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
          child: const Text(
            'เริ่มต้นใช้งาน',
            style: TextStyle(
                color: Color.fromARGB(255, 76, 105, 78),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 218, 240, 183)),
          ),
        ),
      ),
    );
  }

  Row menuHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          },
          icon: const Icon(Icons.person, size: 26),
          label: const Text('Admin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 85, 134, 89),
            ),
          ),
        ),
      ],
    );
  }
}
