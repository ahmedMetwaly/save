import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provider/provider.dart";
import "package:save/controller/my_provider.dart";
import "package:save/model/cash_helper.dart";
import 'package:page_transition/page_transition.dart';
import 'package:save/view/screens/social_media/save_to_social_media.dart';
import "../../core/theme/app_colors.dart";
import "home.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const routeName = "/splashScreen";

  @override
  Widget build(BuildContext context) {
    final cacheHelper = Provider.of<CashHelper>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Consumer<MyProvider>(
          builder: (context, value, child) =>
              AnimatedSplashScreen.withScreenFunction(
            splash: Center(
              child: Image.asset(
                "assets/images/saveAppIcon.png",
                width: 250.w,
                height: 250.h,
                fit: BoxFit.cover,
              ),
            ),
            splashIconSize: double.infinity,
            duration: 2000,
            screenFunction: () async {
              await cacheHelper.loadPref();
              await value.getDataFromOtherApps();
              return value.sharedData == ""
                  ? const Home()
                  : const SaveToSocialMedia();
            },
            splashTransition: SplashTransition.slideTransition,
            animationDuration: const Duration(milliseconds: 2000),
            pageTransitionType: PageTransitionType.topToBottom,
          ),
        ),
      ),
    );
  }
}
