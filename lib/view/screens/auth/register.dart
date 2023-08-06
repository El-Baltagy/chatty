import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/auth.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_colors.dart';
import '../../../shared/utils/app_methods.dart';
import '../../../shared/widgets/button2.dart';
import '../../../shared/widgets/ttf.dart';
import '../lay_out/lay_out.dart';

class RegisterSc extends StatefulWidget {
   RegisterSc();

  @override
  State<RegisterSc> createState() => _RegisterScState();
}

class _RegisterScState extends State<RegisterSc> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  // final  GlobalKey<FormState>formNameKey=GlobalKey<FormState>();
  // final  GlobalKey<FormState>formEmailKey=GlobalKey<FormState>();
  // final  GlobalKey<FormState>formPasswordKey=GlobalKey<FormState>();
  //  final  GlobalKey<FormState>formRepasswordKey=GlobalKey<FormState>();

   final  GlobalKey<FormState>formKey=GlobalKey<FormState>();

   // File? image;

   @override
   void dispose() {
     super.dispose();
     _nameController.dispose();
     _emailController.dispose();
     _passwordController.dispose();
     _repasswordController.dispose();
   }
    late String passVal;
   // void pickImage() async {
   //   image = await pickImageFromGallery(context);
   //   setState(() {});
   // }

  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<AuthProv>(context,listen: false);
    return Scaffold(
      body: Center(
        child: Form(
          key:formKey ,
          // onChanged: () {
          //   if (formKey.currentState!.validate()) {}
          // },
          // autovalidateMode:AutovalidateMode.onUserInteraction ,
          child: SingleChildScrollView(
            child: Column(
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
                  "Register Now to Communicate with firends",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ),

                //enter data

                Stack(
                  children: [
                    provider.image == null
                        ? const CircleAvatar(
                      backgroundImage: NetworkImage(
                        AssetManager.defaultImg,
                      ),
                      radius: 64,
                    )
                        : CircleAvatar(
                      backgroundImage: FileImage(
                        provider.image!,
                      ),
                      radius: 64,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: Consumer<AuthProv>(
                      builder: (context, prov, child) {
                         return IconButton(
                        onPressed: () => prov.selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      );
  },
),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                buildTextFormField(
                  labelTitle: 'name',
                  controller:_nameController ,
                  type:TextInputType.name ,

                  validator: (val) => valid(val!,5,20),
                  // onSubmit: (p0) {
                  //
                  // },
                ),
                buildTextFormField(
                  labelTitle: 'email',
                  controller:_emailController ,
                  type:TextInputType.emailAddress ,
                  validator: (val) => valid(val!,5,50,isEmail: true,contrller: _emailController),
                ),
                buildTextFormField(
                  labelTitle: 'password',
                  controller:_passwordController ,
                  type:TextInputType.visiblePassword ,
                  validator: (val) => valid(val!,5,20),
                  onSubmit: (val){
                    setState(() {
                      passVal=val.toString().trim();
                    });
                  },
                ),
                buildTextFormField(
                  labelTitle: 'confirm password',
                  controller:_repasswordController ,
                  type:TextInputType.visiblePassword ,
                  validator: ( val){
                    if (val!.toString().trim().isEmpty) {
                      return 'can\'t be Empty';
                    }
                    if (passVal!=val.toString().trim()) {
                     return 'Non identical password';
                    }
                    return null;
                  },
                ),
                CustomButton(
                  onPressed: ()async{
                    if (formKey.currentState!.validate()) {
                      bool? res;
                      res=  await provider.register(context,
                          email: _emailController.text.trim(),
                          password:_passwordController.text.trim(),
                          name:  _nameController.text.trim(),
                          image: provider.image!
                      );
                      if (res!) {
                        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LayOut()), (route) => false);
                           Future.delayed (const Duration(milliseconds: 150)).whenComplete(
                                   () => GoPage().navigateAndFinish(context, const LayOut()));
                      }
                    }
                  },
                  text: ('register'.toUpperCase()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
