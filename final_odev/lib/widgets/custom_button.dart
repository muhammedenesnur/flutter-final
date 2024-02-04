// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

//DİĞER SAYFALARDA KULLANMAK İÇİN OLUŞTURDUĞUMUZ CUSSTOM BUTTON İÇİNE height width onPressed text PARAMETRELERİNİ ALIYOR.
//ÇAĞIRINCA BİZDEN İSTEYECEĞİ ŞEYLER
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final double height;
  final double width;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
