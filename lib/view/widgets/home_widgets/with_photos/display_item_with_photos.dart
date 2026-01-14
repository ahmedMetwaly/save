import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/screens/make_edit.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';
import 'item_content/bottom_of_item.dart';
import 'item_content/center_of_item/add_photo.dart';
import 'item_content/center_of_item/display_photos.dart';
import 'item_content/head_of_item.dart';

class DisplayItemWithPhotos extends StatelessWidget {
  const DisplayItemWithPhotos({
    super.key,
    required this.labelList,
    required this.imagesList,
    required this.valuesList,
    required this.urlsList,
    required this.title,
    required this.categoryName,
    required this.favScreen,
    required this.fromSearchScreen,
  });
  final List<String> labelList;
  final List<String> imagesList;
  final List<String> valuesList;
  final List urlsList;
  final String title;
  final String categoryName;
  final bool favScreen;
  final bool fromSearchScreen;

  deleteFromCategory(BuildContext context) {
    final value = Provider.of<MySql>(context, listen: false);

    String spContent =
        value.selectSpecificContent(categoryName: categoryName, title: title);
    int endIndex = spContent.indexOf("]");
    String oldContent = spContent.substring(0, endIndex);
    value.updateSpecificContent(
        db: value.database,
        newContent: "",
        categoryName: categoryName,
        oldContent: "$oldContent]");
    List favContent = value.favList.map((fav) => fav["content"]).toList();
    if (favContent.contains("$oldContent]")) {
      value.deleteFromFav(content: "$oldContent]");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MySql>(
      builder: (context, value, child) => Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.cardDark.withOpacity(0.5)
                    : AppColors.backgroundLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: HeadOfItem(
                      labelList: labelList,
                      urls: urlsList,
                      valuesList: valuesList,
                    ),
                  ),
                  if (!fromSearchScreen) ...[
                    SizedBox(width: 8.w),
                    _buildActionButtons(context),
                  ],
                ],
              ),
            ),

            // Divider
            Divider(
              height: 1,
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 90.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DisplayPhotos(
                          imagesList: imagesList,
                          title: title,
                          categoryName: categoryName,
                        ),
                        SizedBox(width: 12.w),
                        AddPhoto(title: title, categoryName: categoryName),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BottomOfItem(
                    categoryName: categoryName,
                    labelList: labelList,
                    valuesList: valuesList,
                    imagesList: imagesList,
                    title: title,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(
          context,
          icon: Icons.edit_rounded,
          color: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Edit(
                  labelList: labelList,
                  categoryName: categoryName,
                  title: title,
                  valueList: valuesList,
                ),
              ),
            );
          },
        ),
        if (!favScreen) ...[
          SizedBox(width: 8.w),
          _buildIconButton(
            context,
            icon: Icons.delete_outline_rounded,
            color: AppColors.error,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ShowAlertDialog(
                    title: "Delete Item",
                    content: "Are you sure you want to delete this item?",
                    onPressedOk: () {
                      deleteFromCategory(context);
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          size: 20.sp,
          color: color,
        ),
      ),
    );
  }
}
