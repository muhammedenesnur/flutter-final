import 'package:final_odev/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
          children: [
            SizedBox(height: height * 0.15),
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
            Image.asset('assets/images/getStart.png', height: height * 0.45),
            SizedBox(height: height * 0.05),
            CustomButton(
                height: height * 0.06,
                width: width * 0.3,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                text: 'Login'),
            SizedBox(height: height * 0.02),
            const Text('Or',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const Divider(endIndent: 150, indent: 150, thickness: 3),
            SizedBox(height: height * 0.02),
            CustomButton(
                height: height * 0.06,
                width: width * 0.6,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/register', (route) => false);
                },
                text: 'Create a new account')
          ],
        )
      ],
    ));
  }
}
