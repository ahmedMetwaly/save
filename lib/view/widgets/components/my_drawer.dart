import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:save/model/cash_helper.dart";
import "package:save/view/screens/add_category.dart";
import "package:save/view/screens/fav.dart";
import "../../../core/theme/app_colors.dart";
import "../../screens/social_media/display_social_media.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CashHelper>(
      builder: (context, value, child) => SafeArea(
        child: Drawer(
          backgroundColor: Theme.of(context).canvasColor,
          child: Column(
            spacing: 16.h,
            children: [
              _buildHeader(context, value.isDark!),
              _buildMenuItem(
                icon: Icons.note_add_rounded,
                title: "Add Category",
                onTap: () =>
                    Navigator.of(context).pushNamed(AddCategory.routeName),
                isDark: value.isDark!,
              ),
              _buildMenuItem(
                icon: Icons.favorite,
                title: "Favorite",
                onTap: () =>
                    Navigator.of(context).pushNamed(FavScreen.routeName),
                isDark: value.isDark!,
              ),
              ListTile(
                onTap: () => Navigator.of(context)
                    .pushNamed(DisplaySocialMedia.routeName),
                leading: CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/plateforms.png"),
                  radius: 18.r,
                ),
                title: Text(
                  "Social Media Data",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              Divider(
                color: value.isDark!
                    ? AppColors.borderDark
                    : AppColors.borderLight,
              ),
              _buildThemeToggle(value.isDark!, () {
                value.setPref(value.kIsDark, !value.isDark!);
                value.loadPref();
              }),
              /*    SwitchListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.brightness_6_sharp,
                      color: Theme.of(context).indicatorColor,
                      size: 30.sp,
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Text(
                      "Theme",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16.sp,
                          ),
                    ),
                  ],
                ),
                value: value.isDark!,
                onChanged: (val) {
                  value.setPref(value.kIsDark, val);
                  value.loadPref();
                },
              ),
            */
              Spacer(),
              _buildFooter(context, value.isDark!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark, VoidCallback onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: AppColors.primaryStart,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          Switch(
            value: isDark,
            onChanged: (_) => onChanged(),
            activeColor: AppColors.primaryStart,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.asset(
              "assets/images/saveAppIcon.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Save',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Your personal data manager',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        'Version 1.0.0',
        style: TextStyle(
          fontSize: 12.sp,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: AppColors.primaryStart,
          size: 24.sp,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color:
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        hoverColor: AppColors.primaryStart.withValues(alpha: 0.1),
      ),
    );
  }
}
