import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction({
    super.key,
    required this.isDark,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });
  final bool isDark;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor ??
                    (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
