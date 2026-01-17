import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save/core/theme/app_colors.dart';
import 'package:save/view/screens/home.dart';
import '../../screens/search.dart';

AppBar myAppBar(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor:
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
    leading: Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(12.r),
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
            child: Icon(
              Icons.menu_rounded,
              size: 22.sp,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    ),
    leadingWidth: 70.w,
    title: InkWell(
      onTap: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
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
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 22.sp,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                "Search...",
                style: TextStyle(
                  color:
                      isDark ? AppColors.textHintDark : AppColors.textHintLight,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      Builder(
        builder: (context) => Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryStart.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.home_rounded,
                size: 22.sp,
                color: Colors.white,
              ),
            ),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed(Home.routeName),
          ),
        ),
      ),
    ],
  );
}
