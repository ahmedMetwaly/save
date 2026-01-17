import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save/core/theme/app_colors.dart';

import '../../widgets/components/gradient_sliver_app_bar.dart';
import '../../widgets/home_widgets/social_media/platform_button.dart';

class DisplaySocialMedia extends StatelessWidget {
  const DisplaySocialMedia({super.key});
  static const String routeName = "/displaySocialMedia";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<String> platforms = [
      "facebook",
      "instagram",
      "twitter",
      "snapchat",
      "tiktok",
      "youtube",
      "chrome",
      "linkedin"
    ];

    // Platform colors for icons
    Map<String, Color> platformColors = {
      "facebook": AppColors.facebook,
      "instagram": AppColors.instagram,
      "twitter": AppColors.twitter,
      "snapchat": AppColors.snapchat,
      "tiktok": AppColors.tiktok,
      "youtube": AppColors.youtube,
      "chrome": AppColors.chrome,
      "linkedin": AppColors.linkedin,
    };

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Gradient App Bar
          const GradientSliverAppBar(
            title: "Social Media",
            showBackButton: true,
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  // Info Text
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.link_rounded,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Saved Links",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Tap on a platform to view saved links",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Platform Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: platforms.length,
                    itemBuilder: (context, index) {
                      final platform = platforms[index];
                      final color =
                          platformColors[platform] ?? AppColors.primaryStart;

                      return _buildPlatformCard(
                        context: context,
                        isDark: isDark,
                        platform: platform,
                        color: color,
                        appIcon: "assets/images/$platform.png",
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformCard({
    required BuildContext context,
    required bool isDark,
    required String platform,
    required Color color,
    required String appIcon,
  }) {
    return PlatformButton(
      platform: platform,
      appIcon: appIcon,
      display: "yes",
      customBuilder: (onTap) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : color.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    appIcon,
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  platform.toUpperCase(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
