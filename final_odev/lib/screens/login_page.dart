import 'package:final_odev/service/service.dart';
import 'package:final_odev/widgets/custom_button.dart';
import 'package:final_odev/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //SERVİSİ BURADA KULLANMAK İÇİN NESNSEYİ OLUŞTURUYORUZ
  final Service _service = Service();

  //VERİLERİ UYGULAMA KAPANIRSA VEYA YENİDEN BAŞLATILIRSA DİYE SAKLAMAK İÇİN SHAREDPREFERENCES KULLANDIK. LOCAL VERİTABANI
  storeData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    storeage.setString("Email", _emailController.text);
  }

  //KAYDETTİĞİMİZ VERİLERİ EKRANDA GÖSTERMEK İÇİN YAZILDI
  readData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    var mail = storeage.getString("Email");

    setState(() {
      _emailController.text = mail ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    //BU SAYFA AÇILDIĞINDA KAYDEDİLEN VERİLERİ EKRANDA GÖSTERMEK İÇİN
    readData();
  }

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
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
            SizedBox(height: height * 0.03),
            const Text('Hello',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: height * 0.05),
            //BU WİDGETI KENDİMİZ OLUŞTURDUK ÇAĞIIRYORUZ
            CustomTextField(
              labeltext: 'E-mail',
              icon: const Icon(Icons.mail),
              obsecureText: false,
              controller: _emailController,
            ),
            CustomTextField(
              icon: const Icon(Icons.key),
              labeltext: 'Password',
              obsecureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: height * 0.05),
            CustomButton(
                height: height * 0.06,
                width: width * 0.4,
                onPressed: () async {
                  //WEB SERVİSE ATTIĞIMIZ İSTEK İLE GİRİLEN ŞİFRE EŞİT Mİ DEĞİL Mİ KONTROLU YAPILIYOR
                  if (_passwordController.text == 'cityslicka') {
                    //EŞİTSE GİRİŞ BAŞARILI OLUYOR VE VERİLER VERİTABANINA KAYIT EDİLİYOR
                    _service.login(
                        _emailController.text, _passwordController.text);
                    storeData();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Giriş Başarılı')));
                    await Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  } else {
                    //DEĞİLSE ŞİFRE HATALI
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Giriş Başarısız')));
                  }
                },
                text: 'Sign In'),
            SizedBox(height: height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don’t have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: width * 0.05),
                CustomButton(
                    height: height * 0.04,
                    width: width * 0.3,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/register', (route) => false);
                    },
                    text: 'Create'),
              ],
            ),
          ],
        )
      ],
    ));
  }
}
