import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  bool? isVerify;
  Color? color;
  Widget? widget;
  final VoidCallback onPressed;
   CustomButton({
    Key? key,
    required this.text,this.isVerify=false,this.color=Colors.blue,this.widget,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isVerify!) widget!,
          Text(
            text,
          ),
        ],
      ),
    );
  }
}