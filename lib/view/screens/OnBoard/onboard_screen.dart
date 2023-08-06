import 'package:chatty/view/screens/auth/login.dart';
import 'package:chatty/view/screens/lay_out/lay_out.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../shared/network/local/cach_helper.dart';
import '../../../shared/utils/app_colors.dart';
import '../../../shared/utils/app_strings.dart';
import '../../../shared/utils/app_textstyle.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/responsive.dart';
import '../../../shared/utils/app_methods.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetManager.backgroung), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: rhight(context) / 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    AppStrings.appName,
                    style: AppTextStyle.textAppNamestyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: rhight(context) / 2.4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: rhight(context) / 20,
                          horizontal: rwidth(context) / 15),
                      child: Column(
                        children: [
                          const Text(
                            AppStrings.onBoardingText,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.onBoardingText,
                          ),
                          SizedBox(
                            height: rhight(context) / 50,
                          ),
                          const Text(
                            AppStrings.onBoardingText2,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.onBoardingText2,
                          ),
                          SizedBox(
                            height: rhight(context) / 20,
                          ),
                          SizedBox(
                            width: rwidth(context) / 1.3,
                            child: SwipeableButtonView(
                                onFinish: () async {
                                  debugPrint('open');
                                  SaveDataToPrefs.saveData(
                                      key: 'onBoard', value: true);
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginSc()));
                                  GoPage().navigateAndFinish(context, LoginSc());
                                },
                                onWaitingProcess: () {
                                  setState(() {
                                    isFinished = true;
                                  });
                                },
                                activeColor: Colors.blue.shade900,
                                isFinished: isFinished,
                                buttonWidget: SizedBox(
                                  height: rhight(context) / 8,
                                  child: Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    color: AppColors.baseColor,
                                    size: 35,
                                  ),
                                ),
                                buttonText: 'Swipe to start ...'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
