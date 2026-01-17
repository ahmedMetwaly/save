import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/core/theme/app_colors.dart';

import '../../../controller/my_provider.dart';

class ContainsImage extends StatelessWidget {
  const ContainsImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MyProvider>(
      builder: (context, val, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: val.containsImage
                    ? AppColors.primaryStart.withValues(alpha: 0.15)
                    : (isDark ? AppColors.cardDark : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.image_rounded,
                color: val.containsImage
                    ? AppColors.primaryStart
                    : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enable Images",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Allow adding photos to items",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: val.containsImage,
              onChanged: (value) => val.changeSwitch(value),
              activeColor: AppColors.primaryStart,
              activeTrackColor: AppColors.primaryStart.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
