import 'dart:async';
import 'dart:io';
import 'package:chatty/shared/utils/global.dart';
import 'package:chatty/shared/utils/app_methods.dart';
import 'package:chatty/view/screens/lay_out/group_screen/group_sc.dart';
import 'package:chatty/view/screens/lay_out/home/chat_list/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../models/user_model.dart';
import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/button2.dart';
import 'home/history/history.dart';
import 'home/status/confirm_status_sc.dart';
import 'home/status/status_contact_sc.dart';
import 'home/status/status_sc.dart';
import 'search_chat/search_chat.dart';

class LayOut extends StatefulWidget {
  const LayOut({super.key});

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabBarController;
  late bool isEmailVerified;
  bool canSendAgain=false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
     getCurrentUserData();
    // startTimer();
    currentFirebaseUser=fAuth.currentUser;
    isEmailVerified=fAuth.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendEmailVerification();
    }
    timer=Timer.periodic(const Duration(seconds: 3),
            (_)=>checkEmailVerified());
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();

  }

  @override
  Widget build(BuildContext context) {
    return  !isEmailVerified? Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 200.h, bottom: 15.h),
              child: Text(
                "your account hasn't been verified ....!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),

            ),

            Text(
              "Please visit your mail to active it",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),SizedBox(
              height:50.h ,
            ),
            CustomButton(
              text: 'sign out'.toUpperCase(),
              color: Colors.grey,
              onPressed: ()async {
            await fAuth.signOut();
              },),
          ],
        ),
      ),
    ):
    DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          centerTitle: false,
          leading: CircleAvatar(),
          title: const Text(
            'chatty',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text(
                    'Create Group',
                  ),
                  onTap: () => GoPage().push(context, path:const GroupSC() )
                )
              ],
            ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: AppColors.tabColor,
            indicatorWeight: 4,
            labelColor: AppColors.tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            chat_list(),
            StatusContactsScreen(),
            History()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: FloatingActionButton(

          onPressed: () async {
            if (tabBarController.index == 0) {
              GoPage().push(context, path: const SearchChatSC());
            } else {
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                ()=>GoPage().push(context, path: ConfirmStatusScreen(file: pickedImage));
              }
            }
          },
          backgroundColor: AppColors.tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  sendEmailVerification()async{
    final user=fAuth.currentUser;
    await user!.sendEmailVerification();
    Fluttertoast.showToast(
        msg: "Verification has been sent...check your mail",
        textColor: Colors.white,timeInSecForIosWeb: 9,
        backgroundColor: Colors.green);
  }

  checkEmailVerified()async{
    await fAuth.currentUser!.reload();

    setState(() {
      isEmailVerified=fAuth.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }
}

Future<UserModel?> getCurrentUserData() async {
  var userData =
  await firestore.collection('users').doc(fAuth.currentUser?.uid).get();


  if (userData.data() != null) {
    user = UserModel.fromMap(userData.data()!);
  }
  return user;
}