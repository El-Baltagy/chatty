import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_assets.dart';

class SigninButton extends StatelessWidget {
  SigninButton({required this.isGoogleSignin, required this.onTap});

  final bool isGoogleSignin;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 295.w,
          height: 44.h,
          decoration: BoxDecoration(
            color:  Colors.blue ,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                  height: 50.h,
                  width: 35.w,
                  child: Image.asset(isGoogleSignin?AssetManager.google:AssetManager.phone)),
               SizedBox(
                width: 25.w,
              ),
              Text(
                "Sign in with ${isGoogleSignin?"Google":"phone"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:AppColors.primaryBackground,// AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ));
  }
}
