import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';

import '../../../../../../controller/my_provider.dart';
import '../../../../../../model/database.dart';

class DisplayPhotos extends StatelessWidget {
  const DisplayPhotos({
    super.key,
    required this.imagesList,
    required this.title,
    required this.categoryName,
  });

  final List<String> imagesList;
  final String title;
  final String categoryName;

  updateInFav(BuildContext context, String deletedImage) {
    final value = Provider.of<MySql>(context, listen: false);
    String spContent = value
        .selectSpecificContent(
          categoryName: categoryName,
          title: title,
        )
        .trim();
    int endIndex = spContent.indexOf("]");
    String oldContent = "${spContent.substring(0, endIndex)}]";
    List images = value.fetchImages(oldContent);
    images.removeWhere((element) => element.toString().trim() == deletedImage);
    List updatedImages =
        images.map((image) => "File: ${image.toString().trim()}").toList();
    String updatedContent = "$title,$updatedImages";

    // print("fav: ${value.favList}");
    List favContent =
        value.favList.map((favItem) => favItem["content"]).toList();
    if (favContent.contains(oldContent)) {
      value.updateFavItem(newContent: updatedContent, oldContent: oldContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MySql>(
      builder: (context, value, child) {
        final watch = context.watch<MyProvider>();
        // print(imagesList.length);
        return imagesList.toString() != "[]"
            ? ListView.separated(
                itemCount: imagesList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  radius: 20.r,
                  onTap: () {
                    watch.openPhoto(context,
                        categoryName: categoryName,
                        title: title,
                        index: index,
                        galleryItems: imagesList);
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) => imagesList.length != 1
                            ? ShowAlertDialog(
                                title: "Delete",
                                content: "Do you want to delete this image?",
                                onPressedOk: () {
                                  String deletedImage =
                                      imagesList[index].trim();
                                  value
                                      .deletePhoto(context,
                                          deletedPhoto: deletedImage,
                                          categoryName: categoryName,
                                          title: title)
                                      .then((val) {
                                    updateInFav(context, deletedImage);
                                    Navigator.of(context).pop();
                                  });
                                },
                              )
                            : AlertDialog(
                                title: const Text("Warnning"),
                                content:
                                    const Text("It must be at least one image"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text("Ok")),
                                ],
                              ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image(
                      image: FileImage(
                        File(imagesList[index].trim().replaceAll("'", "")),
                      ),
                      //frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>  child ,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              value: 98,
                            ),
                          );
                        }
                      },
                      alignment: Alignment.center,
                      width: 150.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.w,
                ),
              )
            : const SizedBox();
      },
    );
  }
}
