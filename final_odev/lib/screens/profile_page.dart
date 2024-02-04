import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //MAİL CONTROLLER OLUŞTURDUK
  final TextEditingController emailController = TextEditingController(text: "");

  //VERİTABANINA KAYDETTİĞİMİZ MAİLİ UYGULAMA AÇILINCA OKUMAK İÇİN
  readData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    var email = storeage.getString("email");

    setState(() {
      emailController.text = email ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    //BU SAYFA AÇILINCA VERİYİ GÖSTER
    readData();
  }

  //VERİTABANINA KAYDEDİLEN VERİYİ SİLMEK İÇİN. YANİ ÇIKIŞ YAPMAK İÇİN LOGOUT
  clearData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    storeage.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xff5c2d91),
        body: Center(
          child: SizedBox(
            height: height * 0.05,
            width: width * 0.4,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                //LOGOUT TUŞUNA BASINCA VERİYİ SİLİP welcome SAYFASINA ATIYOR
                clearData();
                Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout_outlined,
                    color: Color(0xff5c2d91),
                  ),
                  SizedBox(width: width * 0.02),
                  const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, color: Color(0xff5c2d91)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
