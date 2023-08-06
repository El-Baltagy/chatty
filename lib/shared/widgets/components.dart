import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class LoginComponent extends StatelessWidget {
  const LoginComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            height: rhight(context) / 2.2,
            width: rwidth(context),
            color: AppColors.baseColor,
          ),
        ),
        Positioned(
          top: rhight(context) / 4,
          child: Container(
            height: rhight(context) / 7,
            width: rwidth(context) / 3.8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.chat_outlined,
              size: 40,
              color: AppColors.baseColor,
            ),
          ),
        )
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double w = size.width;
    // double h = size.height;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(size.width * 0.1642857, size.height * 0.7707143,
        size.width * 0.4542857, size.height * 0.7285714);
    path0.cubicTo(
        size.width * 0.6028571,
        size.height * 0.7071429,
        size.width * 0.9742857,
        size.height * 0.5928571,
        size.width,
        size.height * 0.4714286);
    path0.quadraticBezierTo(
        size.width * 1.0142857, size.height * 0.3564286, size.width, 0);

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
