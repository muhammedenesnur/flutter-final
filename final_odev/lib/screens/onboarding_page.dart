import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //SAYFANIN CONTROLLERI
  PageController controller = PageController();

  //FOTOĞRAGLARI LİSTE ŞEKLİNDE TUTUYORUM
  List<String> list = ['assets/images/isu1.jpg', 'assets/images/isu2.jpg'];

  //İLK SAYFANIN İNDEXİ
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE TASARIM İÇİN
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      itemCount: list.length,
      onPageChanged: (value) {
        //BASTIĞIMDA DİĞER SAYFAYA GİTMESİN İÇİN
        setState(() {
          currentIndex = value;
        });
      },
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.asset(
              list[index],
              height: height * 1,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      list.length,
                      (index) {
                        return Container(
                          height: 5,
                          width: currentIndex == index ? 30 : 10,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == index ? Colors.white : Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //BUTONUMUZ
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      fixedSize: Size(width * 0.8, height * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    //OLDUĞUMUZ SAYFA İLE LİSTEDEKİ SAYFA AYNI İSE YANİ SAYFALAR BİTTİYSE SON SAYFADA İSEK WELCOME SAYFASINA AT
                    if (currentIndex == list.length - 1) {
                      Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
                    }
                    //ANİMASYONLU OLARAK BİR SONRAKİ SAYFAYA GEÇİŞ
                    controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                SizedBox(height: height * 0.05)
              ],
            )
          ],
        );
      },
    ));
  }
}
