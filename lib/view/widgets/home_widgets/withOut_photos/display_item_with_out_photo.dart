import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/core/theme/app_colors.dart';
import 'package:save/model/database.dart';
import '../../../screens/make_edit.dart';
import '../../components/item_header.dart';
import '../../components/link_preview.dart';
import '../../components/show_alert_dialog.dart';
import 'bottom_of_with_out_photo_item.dart';

class DisplayItemWithOutPhoto extends StatelessWidget {
  const DisplayItemWithOutPhoto({
    super.key,
    required this.itemContent,
    required this.categoryName,
    required this.labelList,
    required this.valueList,
    required this.onSearchScreen,
    required this.onFavScreen,
  });

  final String itemContent;
  final List<String> labelList;
  final List<String> valueList;
  final String categoryName;
  final bool onSearchScreen;
  final bool onFavScreen;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List data = itemContent.split(",");
    data = data
        .map((item) =>
            item.toString().replaceFirst("[", "").replaceFirst("]", "").trim())
        .toList();

    List urls = watch.fetchUrl(itemContent);

    return Consumer<MySql>(
      builder: (context, mySQL, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with actions
              if (!onSearchScreen)
                ItemHeader(
                  title: valueList.isNotEmpty ? valueList[0] : "Item",
                  showActions: true,
                  showDelete: !onFavScreen,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit(
                          labelList: labelList,
                          itemContent: data.toString(),
                          categoryName: categoryName,
                          valueList: valueList,
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => ShowAlertDialog(
                        title: "Delete",
                        content:
                            "Do want to delete ${valueList[0]} from $categoryName?",
                        onPressedOk: () {
                          mySQL
                              .editContentOfWithOutPhoto(
                            categoryName: categoryName,
                            itemContent: itemContent,
                            valueList: valueList,
                            labelList: labelList,
                          )
                              .then((value) {
                            List favContent = mySQL.favList
                                .map((fav) => fav["content"])
                                .toList();
                            if (favContent.contains(itemContent)) {
                              mySQL.deleteFromFav(content: itemContent);
                            }
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    );
                  },
                ),

              // Content
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Data items
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Divider(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                          height: 1,
                        ),
                      ),
                      itemBuilder: (context, indx) {
                        // Check if contains URL
                        for (int i = 0; i < urls.length; i++) {
                          if (urls.isNotEmpty && data[indx].contains(urls[i])) {
                            return _buildDataRow(
                              context: context,
                              isDark: isDark,
                              label: labelList.length > indx
                                  ? labelList[indx]
                                  : "Field ${indx + 1}",
                              value: data[indx].replaceAll(urls[i], "").trim(),
                              urlWidget: LinkPreviewWidget(urlLink: urls[i]),
                            );
                          }
                        }
                        return _buildDataRow(
                          context: context,
                          isDark: isDark,
                          label: labelList.length > indx
                              ? labelList[indx]
                              : "Field ${indx + 1}",
                          value: data[indx],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Bottom actions (favorite, share)
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceDark
                      : AppColors.backgroundLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: BottomOfWithOutPhotosItem(
                  data: data,
                  categoryName: categoryName,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDataRow({
    required BuildContext context,
    required bool isDark,
    required String label,
    required String value,
    Widget? urlWidget,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryStart,
            ),
          ),
          SizedBox(height: 4.h),
          // Value
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 15.sp,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          // URL Widget if exists
          if (urlWidget != null) urlWidget,
        ],
      ),
    );
  }
}
