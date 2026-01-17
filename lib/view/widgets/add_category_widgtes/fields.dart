import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/core/theme/app_colors.dart';

import '../../../controller/my_provider.dart';
import '../components/input_field.dart';

class Fields extends StatelessWidget {
  const Fields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MyProvider>(
      builder: (context, value, child) => Column(
        children: [
          // Fields List
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separatorBuilder: (ctxL, index) => SizedBox(height: 12.h),
            itemCount: value.controllerNumbers,
            itemBuilder: ((ctxL, index) => Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceDark
                        : AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color:
                          isDark ? AppColors.borderDark : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Number Badge
                      Container(
                        width: 28.w,
                        height: 28.h,
                        margin: EdgeInsets.only(top: 12.h),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Input Field
                      Expanded(
                        child: InputField(
                          controller: value.controllers[index],
                          label: "Field Title",
                          hint: "ex: Title, Description, URL...",
                          withMaxLines: false,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Delete Button
                      Container(
                        margin: EdgeInsets.only(top: 6.h),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => value.removeFieldAt(index),
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.error,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          if (value.controllerNumbers > 0) SizedBox(height: 16.h),
          // Add Field Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  value.controllerNumbers < 10 ? () => value.addField() : null,
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: value.controllerNumbers < 10
                      ? (isDark
                          ? AppColors.surfaceDark
                          : AppColors.backgroundLight)
                      : (isDark ? AppColors.cardDark : Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: value.controllerNumbers < 10
                        ? AppColors.primaryStart
                        : (isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        gradient: value.controllerNumbers < 10
                            ? AppColors.primaryGradient
                            : null,
                        color: value.controllerNumbers < 10
                            ? null
                            : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      value.controllerNumbers < 10
                          ? "Add Field"
                          : "Maximum 10 Fields",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: value.controllerNumbers < 10
                            ? AppColors.primaryStart
                            : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
