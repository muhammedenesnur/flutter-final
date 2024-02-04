import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labeltext;
  final Icon icon;
  final TextEditingController? controller;
  final Function(String)? validator;
  final bool obsecureText;
  const CustomTextField({
    Key? key,
    required this.labeltext,
    required this.icon,
    this.controller,
    this.validator,
    required this.obsecureText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
      child: Container(
        height: screenSize.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            color: const Color.fromARGB(255, 207, 207, 207)),
        child: TextFormField(
          obscureText: widget.obsecureText,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            border: InputBorder.none,
            hintText: widget.labeltext,
          ),
        ),
      ),
    );
  }
}
