import 'package:chatty/shared/widgets/ttf.dart';
import 'package:chatty/view/screens/lay_out/lay_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/auth.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/global.dart';
import '../../../../shared/widgets/button2.dart';
import '../../../../shared/widgets/progrfess_dialouge.dart';

class ProfileSc extends StatelessWidget {

  const ProfileSc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
          )),
      body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 15.w,
                  horizontal: 15.w,),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildLogo(context),
                        _buildNameInput(context),
                        _buildDescripeInput(),
                        _buildSeleteStatus(),
                        // CustomButton(text: 'cancel'.toUpperCase(), onPressed: () {
                        //
                        // },color: Colors.grey,),
                        // CustomButton(text: 'confirm',
                        //     onPressed: () {
                        //   showDialog(context: context, builder:(context) =>   Column(
                        //     children: [
                        //       Spacer(
                        //         flex: 1,
                        //       ),
                        //       Text("Are you sure to log out?"),
                        //       Spacer(
                        //         flex:2 ,
                        //       ),
                        //       Row(
                        //         children: [
                        //           CustomButton(text: 'cancel'.toUpperCase(), onPressed: () {
                        //             Navigator.of(context).pop(true);
                        //           },color: Colors.grey,),
                        //           CustomButton(text: 'confirm'.toUpperCase(), onPressed: () {
                        //             //to do
                        //           },color: Colors.green,),
                        //         ],
                        //       ),
                        //       Spacer(
                        //         flex: 1,
                        //       ),
                        //     ],
                        //   ));
                        //     },
                        //     isVerify: true,
                        //     widget: const Icon(Icons.exit_to_app)),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          )),
    );
  }


  Widget _buildLogo(BuildContext context) {
    final provider = Provider.of<AuthProv>(context);

    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 120.w,
        height: 120.w,
        margin: EdgeInsets.only(top: 0.h, bottom: 50.h),
        decoration: BoxDecoration(
          // color: AppColors.primarySecondaryBackground,
          borderRadius: BorderRadius.all(Radius.circular(60.w)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: provider.image == null ?
        CircleAvatar(
          backgroundImage: NetworkImage(
            user!.profilePic,
          ),
          radius: 64,
        ) :
        CircleAvatar(
          backgroundImage: FileImage(
            provider.image!,
          ),
          radius: 64,
        ),
      ),
      Positioned(
          bottom: 50.w,
          right: 0.w,
          height: 35.w,
          child: Consumer<AuthProv>(
            builder: (context, prov, child) {
              return GestureDetector(
                  child: Container(
                    height: 35.w,
                    width: 35.w,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryElement,
                      borderRadius: BorderRadius.all(Radius.circular(40.w)),
                    ),
                    child: Image.asset(
                      "assets/icons/edit.png",
                    ),
                  ), onTap: () async{
                   late bool result;
                    result=await prov.selectImage(context);
                    if (result) {
                      provider. deleteFileFromFirebase('profileImg/${provider.uid}');
                      late String photoUrl ;
                      photoUrl=await provider.storeFileToFirebase('profileImg/${provider.uid}',provider.image!);
                      await firestore.collection('users').doc(fAuth.currentUser!.uid).
                      set({'profilePic': photoUrl});
                    }
              });
            },
          ))

    ]);
  }

  Widget _buildNameInput(BuildContext context) {
    final TextEditingController NameEditingController=TextEditingController();


    return buildTextFormField(
      type: TextInputType.name,
      controller: NameEditingController,
      labelTitle: user!.name.toString(),
      suffix: Icons.save_alt_outlined,
      suffixPressed: ()async{
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext c)
        //     {
        //       return ProgressDialog(message: "Processing, Please wait...",);
        //     }
        // );
        await firestore.collection('users').doc(fAuth.currentUser!.uid).
        set({'name': NameEditingController.text.trim()});
        getCurrentUserData();
        // await Future.delayed(const Duration(seconds: 2),() {
        //   Navigator.of(context).pop(true);
        // },);
      }
    );
  }
  
  Widget _buildDescripeInput() {
    final TextEditingController descriptionEditingController=TextEditingController();
    final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
     return Form(
       key: _formKey,
       child: Column(
         children: [
           buildTextFormField(
             type: TextInputType.text,
             controller: descriptionEditingController,
             labelTitle: user!.bio.toString(),
             maxLines: 3,
             validator: (val) {
               if (val!.isEmpty) {
                 return "Bio Can't be Empty";
               }
               return null;
             } ,
           ),
           SizedBox(
             height: 5.h,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               CustomButton(text: 'Apply', onPressed: ()async{
                 if (_formKey.currentState!.validate()) {
                   await firestore.collection('users').doc(fAuth.currentUser!.uid).
                   set({'bio': descriptionEditingController.text.trim()});
                 }
               })
             ],
           )
         ],
       ),
     );

  }

  Widget _buildSeleteStatus() {

    return  Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            margin: EdgeInsets.only(left: 15.w),
            decoration: BoxDecoration(
              color: user!.isOnline?Colors.green:AppColors.primarySecondaryElementText,
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
            ),
          ),
          SizedBox(
              width: 200.w,
              height: 44.h,
              child:buildTextFormField(
                type: TextInputType.multiline,
                 readOnly: true,
                maxLines: 3,
                labelTitle:
                user!.isOnline?"Online":"Offline",
                 )),

          Container(
            width: 50.w,
            height: 30.w,
            padding: EdgeInsets.only(left: 0.w),
            decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      width: 2.w, color: AppColors.primarySecondaryElementText),
                )),
            child: DropdownButtonHideUnderline(
                child:DropdownButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 35,
                    iconEnabledColor: AppColors.primarySecondaryElementText,
                    hint: const Text(''),
                    elevation:0,
                    isExpanded: true,
                    // underline:Container(),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Online')),
                      DropdownMenuItem(value: 2, child: Text('Offline')),
                    ],
                    onChanged: (value) async{
                      if (value==1) {
               await firestore.collection('users').doc(fAuth.currentUser!.uid).
              set({'isOnline': 'Online'});

                      }else{
           await firestore.collection('users').doc(fAuth.currentUser!.uid).
           set({'isOnline': 'Offline'});
         }}
                    )),
          )
        ],
      );
  }


  Widget buildStartDecoration( Widget widget) {
    return Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(bottom: 20.h, top: 0.h),
        padding: EdgeInsets.all(0.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: widget);
  }


}
