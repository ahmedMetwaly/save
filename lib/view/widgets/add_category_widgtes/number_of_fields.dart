import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/core/theme/app_colors.dart';

import '../../../controller/my_provider.dart';

class NumberOfFileds extends StatelessWidget {
  const NumberOfFileds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MyProvider>(
      builder: (context, value, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                color: AppColors.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.format_list_numbered_rounded,
                color: AppColors.secondary,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Custom Fields",
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
                    "Add custom text fields",
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
            Row(
              children: [
                _buildCounterButton(
                  context: context,
                  isDark: isDark,
                  icon: Icons.remove_rounded,
                  onPressed: () =>
                      value.changeControllerNumbers(operation: "minus"),
                  isEnabled: value.controllerNumbers > 0,
                ),
                Container(
                  width: 50.w,
                  alignment: Alignment.center,
                  child: Text(
                    "${value.controllerNumbers}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ),
                _buildCounterButton(
                  context: context,
                  isDark: isDark,
                  icon: Icons.add_rounded,
                  onPressed: () =>
                      value.changeControllerNumbers(operation: "add"),
                  isEnabled: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterButton({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            gradient: isEnabled ? AppColors.primaryGradient : null,
            color: isEnabled
                ? null
                : (isDark ? AppColors.cardDark : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.primaryStart.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: isEnabled
                ? Colors.white
                : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
