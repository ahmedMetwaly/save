import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../model/database.dart';
import '../../screens/social_media/display_social_media.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categoryNames,
  });

  final List categoryNames;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return Container(
          height: 45.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: categoryNames.length + 1,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              // Social Media Item (First Item)
              if (index == 0) {
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(DisplaySocialMedia.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.cardGradient,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryStart.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          Icons.public,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Social Media",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Category Items
              final categoryIndex = index - 1;
              final isSelected = tabController.index == categoryIndex;
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return GestureDetector(
                onTap: () {
                  tabController.animateTo(categoryIndex);
                },
                onLongPress: () => context.read<MySql>().deleteCategory(context,
                    categoryName: categoryNames[categoryIndex]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? AppColors.primaryGradient
                        : LinearGradient(
                            colors: isDark
                                ? [AppColors.surfaceDark, AppColors.surfaceDark]
                                : [
                                    AppColors.surfaceLight,
                                    AppColors.surfaceLight
                                  ],
                          ),
                    color: isSelected
                        ? null
                        : (isDark
                            ? AppColors.surfaceDark
                            : AppColors.surfaceLight),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : (isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color:
                                  AppColors.primaryStart.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 120.w),
                    child: Text(
                      categoryNames[categoryIndex],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight),
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
