import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_odev/models/news_model.dart';
import 'package:final_odev/screens/contact_page.dart';
import 'package:final_odev/screens/news_detail_page.dart';
import 'package:final_odev/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ANASAYDAFA GÖSTERECEĞİM RESİMLERİ BİR LİSTEDE TUTUYORUM Kİ DAHA SONRA LİSTELEYEBİLEYİM
  final images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg'
  ];

  //BU FONKSİYON HABERLERİM İÇİN YAZILDI. İÇİNE OLUŞTURDUĞUM MODELİ ALIYOR VE MODELİN İÇİNDEN İMAGE TİTTLE DESC ÇAĞIRILIP DOLDURULUYOR.
  Future<List<NewsModel>> news() async {
    //BURADA BOŞ BİR LİSTE OLUŞTURUYORUZ
    final newsList = <NewsModel>[];
    final n1 = NewsModel(
        image: 'assets/images/n1.jpg',
        title: 'FORMULA 1',
        description: "F1 Las Vegas Grand Prix'sinde pole pozisyonu Leclerc'in");
    final n2 = NewsModel(
        image: 'assets/images/n2.jpg',
        title: 'FENERBAHÇE BEKO',
        description: "Fenerbahçe Beko'nun genç yıldızı kafa travması geçirdi!");
    final n3 = NewsModel(
        image: 'assets/images/n3.jpg',
        title: 'TRENDYOL 1.LİG',
        description:
            "Gençlerbirliği, Türkgücü Münih ile iş birliği anlaşması yaptı");
    //NEWS FONKSİYONUNUN İÇİNDEKİ HER ÖĞREYİ YENİ LİSTEYE ATIYORUZ ÇÜNKÜ O LİSTEYİ EKRANDA LİSTELEMEK İÇİN
    newsList.add(n1);
    newsList.add(n2);
    newsList.add(n3);
    return newsList;
  }

  //DRAWER'IN SEÇİLİ GELEN ELEMANININ İNDEXİNİ AYARLIYORUZ. HANGİ İNDEXTEKİ SAYFA GELSİN DİYE SAYFA 0 HOME
  int _selectedIndex = 0;

  //BASTIĞIMIZ SAYFAYA GİTMEK İÇİN.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  //İNDEX 0 İSE HOME İNDEX 1 İSE CONTACT İNDEX 2 İSE PROFİLE PAGE E GİTSİN DİYORUZ. DRAWER DA BASTIĞIMIZDA GİTMESİNİ SAĞLIYORUZ.
  Widget buildBodyContent(int index) {
    final height = MediaQuery.of(context).size.height;
    if (index == 0) {
      return index0(height);
    } else if (index == 1) {
      return const ContactPage();
    } else if (index == 2) {
      return const ProfilePage();
    } else {
      return const Text('Hata');
    }
  }

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff5c2d91),
      appBar: AppBar(
        title: Image.asset('assets/logo/logo.png', height: height * 0.06),
        backgroundColor: const Color(0xff5c2d91),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      //EKRANIN BODYSİNDE YUKARIDA YAZMIŞ OLDUĞUMUZ FONKSİYONU ÇAĞIRIYORUZ İNDEXE GÖRE BELLİ OLACAK
      body: buildBodyContent(_selectedIndex),
      //DRAWER PENCERESİNİN İÇERİĞİ
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: height * 0.05),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                    radius: 50),
                SizedBox(height: height * 0.02),
                Text(
                  //EĞER YENİ BİR KAYIT OLUŞTURUYORSA PROFİLDE O KISMIN MAİL ADRESİ YAZSIN EĞER SERVİSTEKİ KULLANICI İLE GİRİŞ YAPIYORSA ONU GÖSTERMESİ İÇİN SORGU
                  emailController.text.isNotEmpty
                      ? emailController.text
                      : 'eve.holt@reqres.in',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const Divider(thickness: 2),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Contact us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  //İMAGE LİSTESİ OLUŞTURMUŞTUK ONU LİSTELEMEK İÇİN WİDGET
  Widget buildImage(String urlImage, int index) => Container(
        color: Colors.grey,
        child: Image.asset(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  //HOME SAYFASINI BURADA OLUŞTURDUM METHOD OALRAK DIŞARI ÇIKARP KULLANIYORUM
  Column index0(double height) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            //RESİMLERİN KENDİ KENDİNE SÜRELİ BİR ŞEKİLDE GEÇMESİ İÇİN GEREKLİ WİDGET
            return CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                final urlImages = images[index];
                return buildImage(urlImages, index);
              },
              options: CarouselOptions(
                height: height * 0.2565,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            );
          },
        ),
        // YUKARIDA OLUŞTURDUĞUM NEWS FONSKİYONUNU LİSTELİYORUM
        SizedBox(
          height: height * 0.6,
          child: FutureBuilder<List<NewsModel>>(
            future: news(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final newsList = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetail(news: news),
                          ),
                        );
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(1),
                                      color: Colors.pink,
                                      child: Text(
                                        news.title,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      news.description,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(news.image,
                                  height: height * 0.13),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center();
              }
            },
          ),
        ),
      ],
    );
  }
}
