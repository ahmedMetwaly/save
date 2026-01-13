import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import '../../../../../../controller/my_provider.dart';

class AddPhoto extends StatelessWidget {
  final String title;
  final String categoryName;
  const AddPhoto({
    required this.title,
    required this.categoryName,
    super.key,
  });

  updateInFav(BuildContext context) {
    final value = Provider.of<MySql>(context, listen: false);
    final make = Provider.of<MyProvider>(context, listen: false);
    String spContent =
        value.selectSpecificContent(categoryName: categoryName, title: title);
    int endIndex = spContent.indexOf("]");
    String oldContent = spContent.substring(0, endIndex);
    List images = value.fetchImages(spContent);
    make.files.removeWhere((element) => images.contains(element));
    if (make.files.isNotEmpty) {
      String updatedContent =
          oldContent.endsWith("File:") || oldContent.endsWith("[")
              ? make.files.toString().replaceAll("[", "")
              : "$oldContent, ${make.files.toString().replaceAll("[", "")}";
      if (value.favList.isNotEmpty) {
        //print("fav: ${value.favList}");
        List favContent =
            value.favList.map((favItem) => favItem["content"]).toList();
        if (favContent.contains("$oldContent]")) {
          // print("updated content $updatedContent");
          value.updateFavItem(
              newContent: updatedContent, oldContent: "$oldContent]");
          make.files = [];
        }
      } else {
        //print("empty");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final make = context.watch<MyProvider>();
    return Consumer<MySql>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          make.selectImages().then((val) {
            value
                .addPhoto(
              context,
              categoryName: categoryName,
              title: title,
            )
                .then((val) {
              updateInFav(context);
            });
          });
        },
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 150.w,
          height: 150.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Theme.of(context).indicatorColor,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                size: 30.sp,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Add Photo",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
