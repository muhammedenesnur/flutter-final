import 'package:final_odev/widgets/custom_button.dart';
import 'package:final_odev/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //CONTROLLERLAR OLUŞTURULDU
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController fullNameController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController confirmPasswordController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    //SAYFA AÇILINCA KAYDEDİLERN VERİYİ GÖSTER
    readData();
  }

  //YENİ KAYIT OLUŞTURURKEN VERİLERİ VERİTABANINA KAYDETMEK İÇİN
  storeData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();

    storeage.setString("email", emailController.text);
    storeage.setString("fullName", fullNameController.text);
    storeage.setString("password", passwordController.text);
    storeage.setString("passwordAgain", confirmPasswordController.text);
  }

  //OLUŞTURULAN VERİYİ TEMİZLEMEK İÇİN
  clearData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    storeage.clear();
  }

  //KAYDEDİLEN VERİYİ OKUMAK İÇİN
  readData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    var email = storeage.getString("email");
    var fullName = storeage.getString("fullName");
    var password = storeage.getString("password");
    var passwordAgain = storeage.getString("passwordAgain");

    setState(() {
      emailController.text = email ?? '';
      fullNameController.text = fullName ?? '';
      passwordController.text = password ?? '';
      confirmPasswordController.text = passwordAgain ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/bg.jpg',
          height: height * 1,
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('BEİN',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.deepPurple.shade300,
                        fontWeight: FontWeight.bold)),
                const Text('SPORTS',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500))
              ],
            ),
            SizedBox(height: height * 0.05),
            CustomTextField(
              labeltext: 'E-mail',
              icon: const Icon(Icons.mail),
              obsecureText: false,
              controller: emailController,
            ),
            CustomTextField(
              icon: const Icon(Icons.person),
              labeltext: 'Full Name',
              obsecureText: false,
              controller: fullNameController,
            ),
            CustomTextField(
              icon: const Icon(Icons.key),
              labeltext: 'Password',
              obsecureText: true,
              controller: passwordController,
            ),
            CustomTextField(
              icon: const Icon(Icons.key),
              labeltext: 'Password Again',
              obsecureText: true,
              controller: confirmPasswordController,
            ),
            SizedBox(height: height * 0.05),
            CustomButton(
                height: height * 0.06,
                width: width * 0.4,
                onPressed: () {
                  //EĞER KONTROLLERLAR BOŞSA UYARI VERMESİ İÇİN İF
                  if (emailController.text.isEmpty ||
                      fullNameController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Lütfen bütün alanları doldurunuz.')));
                    //EĞER Kİ ŞİFRELER EŞİT DEĞİLSE UYARI VERECEK
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Lütfen şifreleri aynı giriniz.')));
                  } else {
                    //HER ŞEY NORMAL İSE HOME SAYFASINA YÖNLENDİRECEK VE VERİLERİ VERİTABANINA KAYDEDECEK
                    storeData();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data Saved')));
                  }
                },
                text: 'Create'),
          ],
        )
      ],
    ));
  }
}
