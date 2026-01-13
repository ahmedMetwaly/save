import 'package:flutter/material.dart';
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
    return Consumer<MySql>(
      builder: (context, value, child) => Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HeadOfItem(
                        labelList: labelList,
                        urls: urlsList,
                        valuesList: valuesList),
                  ),
                  fromSearchScreen
                      ? SizedBox(
                          height: 15.h,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Edit(
                                            labelList: labelList,
                                            categoryName: categoryName,
                                            title: title,
                                            valueList: valuesList,
                                          )),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              color: Theme.of(context).primaryColor,
                              iconSize: 25.sp,
                            ),
                            favScreen
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ShowAlertDialog(
                                              title: "Delete",
                                              content:
                                                  "Do want to delete ${valuesList[0]} from $categoryName ?",
                                              onPressedOk: () {
                                                deleteFromCategory(context);
                                                Navigator.of(context).pop();
                                              });
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    iconSize: 25.sp,
                                  ),
                          ],
                        ),
                ],
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 80.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DisplayPhotos(
                        imagesList: imagesList,
                        title: title,
                        categoryName: categoryName),
                    SizedBox(width: 10.w),
                    AddPhoto(title: title, categoryName: categoryName),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
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
      ),
    );
  }
}
