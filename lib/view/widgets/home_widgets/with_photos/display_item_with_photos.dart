import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/core/theme/app_colors.dart';
import 'package:save/model/database.dart';
import 'package:save/view/screens/make_edit.dart';
import 'package:save/view/widgets/components/item_header.dart';
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
        margin: EdgeInsets.only(bottom: 4.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Section - Using reusable ItemHeader
            if (!fromSearchScreen)
              ItemHeader(
                title: "${labelList[0]} : ${valuesList[0]}",
                showActions: true,
                showDelete: !favScreen,
                onEdit: () {
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
                onDelete: () {
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

            // Head of Item (labels, values, urls)
            Container(
              padding: EdgeInsets.all(16.w),
              child: HeadOfItem(
                labelList: labelList,
                urls: urlsList,
                valuesList: valuesList,
              ),
            ),

            // Divider
            Divider(
              height: 1,
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),

            // Content Section
            Column(
              children: [
                SizedBox(
                  height: 90.h,
                  child: ListView(
                    padding: EdgeInsets.all(16.r),
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
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceDark
                        : AppColors.backgroundLight,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: BottomOfItem(
                    categoryName: categoryName,
                    labelList: labelList,
                    valuesList: valuesList,
                    imagesList: imagesList,
                    title: title,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
