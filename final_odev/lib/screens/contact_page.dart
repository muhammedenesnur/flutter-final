import 'package:final_odev/widgets/custom_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xff5c2d91),
        body: Center(
          child: SizedBox(
            width: width * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Talk to our Team',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white)),
                SizedBox(height: height * 0.02),
                //URL LAUNCHER KULLANARAK TELEFON NUMARASINA YÖNLENDİREN KOD
                //URLLAUNCHERBUTTON'U WİDGET OLARAK AYIRDIM
                UrlLauncherButton(
                  title: 'Launch Phone Number',
                  icon: Icons.phone,
                  onPressed: () async {
                    Uri uri = Uri.parse('tel:+905333333333');
                    if (!await launcher.launchUrl(uri)) {
                      debugPrint("Could not launch the uri");
                    }
                  },
                ),
                //URL LAUNCHER KULLANARAK WEB SİTESİNE YÖNLENDİREN KOD
                //URLLAUNCHERBUTTON'U WİDGET OLARAK AYIRDIM

                UrlLauncherButton(
                  title: 'Launch Website / URL',
                  icon: Icons.language,
                  onPressed: () {
                    launcher.launchUrl(
                      Uri.parse('https://flutter.dev'),
                      mode: launcher.LaunchMode.externalApplication,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
