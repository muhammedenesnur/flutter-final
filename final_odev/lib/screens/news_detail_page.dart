import 'package:final_odev/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel news;

  const NewsDetail({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

//HOME DA HABERE TIKLAYINCA İÇERİĞİN TAMAMININ GÖSTERİLMESİ İÇİN OLUŞTURDUĞUM SAYFA

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Image.asset('assets/logo/logo.png', height: height * 0.06),
        backgroundColor: const Color(0xff5c2d91),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.news.description,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.02),
            Text(
              widget.news.title,
              style: const TextStyle(
                  color: Colors.pink, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.02),
            Image.asset(
              widget.news.image,
              fit: BoxFit.cover,
              height: height * 0.3,
              // Ensure the image takes up the full width
            ),
          ],
        ),
      ),
    );
  }
}
