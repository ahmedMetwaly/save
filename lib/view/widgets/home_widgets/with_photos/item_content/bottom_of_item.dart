import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/view/widgets/components/button_action.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../model/database.dart';

// ignore: must_be_immutable
class BottomOfItem extends StatelessWidget {
  BottomOfItem(
      {super.key,
      required this.labelList,
      required this.imagesList,
      required this.valuesList,
      required this.categoryName,
      required this.title});
  final List<String> labelList;
  final List<String> imagesList;
  final List<String> valuesList;
  final String categoryName;
  final String title;
  List sharedData = [];
  void fetchData() {
    sharedData.add("category Name: $categoryName\n");
    for (int i = 0; i < labelList.length; i++) {
      sharedData.add("${labelList[i]}: ${valuesList[i]}\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<File?> images = imagesList.map((image) {
      return File(image.trim().replaceAll("'", ""));
    }).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MySql>(
      builder: (context, value, child) {
        bool isFavorite = value.favList
            .any((favItem) => favItem["content"].toString().contains(title));

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonAction(
              isDark: isDark,
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
              iconColor: isFavorite ? AppColors.error : null,
              label: isFavorite ? "Saved" : "Save",
              onTap: () async {
                String content = value.selectSpecificContent(
                    categoryName: categoryName, title: title);

                int endIndex = content.indexOf("]");
                String favContent = content.substring(0, endIndex + 1);
                if (value.favList.any((favItem) =>
                    favItem["content"].toString().contains(title))) {
                  await value.deleteFromFav(content: favContent);
                  //print("found");
                  //print(value.favList);
                } else {
                  await value.insertToFav(context,
                      content: favContent, categoryName: categoryName);
                }
              },
            ),
            SizedBox(width: 12.w),
            ButtonAction(
              isDark: isDark,
              icon: Icons.share,
              label: "Share",
              onTap: () async {
                try {
                  fetchData();
                  // ignore: deprecated_member_use
                  await Share.shareXFiles(
                      images.map((image) => XFile(image!.path)).toList(),
                      text: sharedData
                          .toString()
                          .replaceFirst("[", "")
                          .replaceAll("]", "")
                          .replaceAll(", ", ""));
                } catch (error) {
                  //  print("Error in share $error");
                }
              },
            )
          ],
        );
      },
    );
  }
}
