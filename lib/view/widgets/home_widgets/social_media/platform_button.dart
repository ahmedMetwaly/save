import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/core/theme/app_colors.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/input_field.dart';

import '../../../screens/home.dart';
import '../../../screens/social_media/platform_data.dart';

class PlatformButton extends StatelessWidget {
  const PlatformButton({
    super.key,
    required this.platform,
    required this.appIcon,
    this.display = "No",
    this.customBuilder,
  });

  final String platform;
  final String appIcon;
  final String display;
  final Widget Function(VoidCallback onTap)? customBuilder;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final read = context.read<MyProvider>();
    final make = context.watch<MySql>();

    void insertToPlatform() {
      Scaffold.of(context).showBottomSheet((context) => Container(
            padding: EdgeInsets.only(
                top: 20.h, left: 16.w, right: 16.w, bottom: 16.h),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color:
                          isDark ? AppColors.borderDark : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Title
                  Text(
                    "Add to ${platform.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Input field
                  InputField(
                    controller: controller,
                    label: "Title",
                    hint: "Enter a title for this link",
                    withMaxLines: false,
                  ),
                  SizedBox(height: 24.h),

                  // Add button
                  Consumer<MySql>(
                    builder: (context, value, child) => Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.primaryStart.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await value
                                  .insertToSocialMedia(context,
                                      platform: platform,
                                      title: controller.text,
                                      link: read.sharedData)
                                  .then(
                                (value) {
                                  Navigator.pop(context);
                                  read.sharedData = "";
                                  Navigator.of(context)
                                      .pushNamed(Home.routeName);
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 22.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Add Link",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ));
    }

    void displayData(String platform) async {
      await make.getPlatform(platform: platform);
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushNamed(PlatformData.routeName, arguments: platform);
    }

    VoidCallback onTap =
        () => display == "yes" ? displayData(platform) : insertToPlatform();

    // If customBuilder is provided, use it
    if (customBuilder != null) {
      return customBuilder!(onTap);
    }

    // Default ListTile style
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(
            appIcon,
            width: 32.w,
            height: 32.h,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "${platform.toUpperCase()} links",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color:
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        onTap: onTap,
      ),
    );
  }
}
