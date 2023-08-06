import 'package:chatty/shared/utils/app_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/auth.dart';
import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/button2.dart';
import '../../../shared/widgets/ttf.dart';
import 'register.dart';

class LoginSc extends StatefulWidget {
  const LoginSc({super.key});

  @override
  State<LoginSc> createState() => _LoginScState();
}

class _LoginScState extends State<LoginSc> {

 final TextEditingController passwordController = TextEditingController();
 final TextEditingController emailController = TextEditingController();

 GlobalKey<FormState>formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<AuthProv>(context);
    return Scaffold(
      
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50.h, bottom: 60.h),
                      child: Text(
                        "Chatty .",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.sp,
                        ),
                      ),
                    ),

                    Text(
                      "Sigin in Now to Communicate with firends",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.sp,
                      ),
                    ),

                     SizedBox(height: 30.h),

                    buildTextFormField(
                     labelTitle: 'email',
                     controller:emailController ,
                       onChange: (value) {
                         if (formKey.currentState!.validate()) {}},
                     type:TextInputType.emailAddress ,
                     validator: (val) => valid(val!,5,50,isEmail: true,contrller: emailController)
                    ),
                    buildTextFormField(
                        labelTitle: 'pasword',
                        controller:passwordController ,
                        onChange: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                        type:TextInputType.visiblePassword ,
                        validator: (val) => valid(val!,5,50)
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(onPressed:(){
                          GoPage().push(context, path: RegisterSc());
                        }, child: Text("Register now",),)
                      ],
                    ),
                    Consumer<AuthProv>(
                      builder: (context, prov, child,) {
                        return CustomButton(
                          onPressed: ()async{
                          if (formKey.currentState!.validate()) {
                            await prov.signIn(emailController.text.trim(),passwordController.text.trim(),context);
                          }
                          },
                          text: ('sign in'.toUpperCase()),
                        );

                      },
                    ),

                  ],),
              ),
            ),
          ),
        ),
      ),
    );
  }

}



