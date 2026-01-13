import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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

    return Consumer<MySql>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () async {
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
                    //print("inserted");
                    // print(value.favList);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  size: 30.sp,
                  color: value.favList.any((favItem) =>
                          favItem["content"].toString().contains(title))
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).primaryColor,
                splashRadius: 20.0.r),
            IconButton(
                onPressed: () async {
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
                icon: Icon(Icons.share, size: 30.sp),
                color: Theme.of(context).primaryColor,
                splashRadius: 20.0.r)
          ],
        );
      },
    );
  }
}
