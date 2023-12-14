import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/my_app_bar.dart';
import 'package:save/view/widgets/components/my_drawer.dart';
import 'package:save/view/widgets/home_widgets/social_media/display_platform_item.dart';
import 'package:save/view/widgets/home_widgets/with_photos/display_item_with_photos.dart';
import '../widgets/home_widgets/withOut_photos/display_item_with_out_photo.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});
  static const String routeName = "/favScreen";

  @override
  Widget build(BuildContext context) {
    return Consumer<MySql>(
      builder: (context, value, child) {
        List<String> platforms = [
          "facebook",
          "instagram",
          "twitter",
          "snapchat",
          "tiktok",
          "youtube",
          "chrome",
          "linkedin"
        ];
        List favContent =
            value.favList.map((favItem) => favItem["content"]).toList();
        List favCategoryName =
            value.favList.map((favItem) => favItem["categoryName"]).toList();
        return Scaffold(
          appBar: myAppBar(context),
          drawer: const MyDrawer(),
          body: SafeArea(
            child: favContent.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                              onPressed: () => value.clearFav(context),
                              child: Text(
                                "Clear Favourite",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              bool isSocialItem = platforms.any((platform) =>
                                  platform == favCategoryName[index]);
                              //print("isSocialMedia: $isSocialItem");
                              if (isSocialItem) {
                                List item = favContent[index]
                                    .toString()
                                    .replaceFirst("[", "")
                                    .replaceFirst("]", "")
                                    .split(",");
                                Map itemContent = {
                                  for (var element in item)
                                    element
                                            .toString()
                                            .substring(0,
                                                element.toString().indexOf(":"))
                                            .trim():
                                        element
                                            .toString()
                                            .substring(element
                                                    .toString()
                                                    .indexOf(":") +
                                                1)
                                            .trim()
                                };
                                itemContent["id"] =
                                    int.parse(itemContent["id"]);
                                return DisplayPlatformItem(
                                  platformItem: itemContent,
                                  onSearchScreen: false,
                                  onFavScreen: true,
                                );
                              } else {
                                if (favContent[index]
                                    .toString()
                                    .contains("File")) {
                                  Map dataWithPhotos = value.fetchDataToDisplay(
                                      context, favContent[index]);
                                  return DisplayItemWithPhotos(
                                      fromSearchScreen: false,
                                      favScreen: true,
                                      labelList: dataWithPhotos["labelsList"],
                                      imagesList: dataWithPhotos["imagesList"],
                                      valuesList: dataWithPhotos["valuesList"],
                                      urlsList: dataWithPhotos["urlsList"],
                                      title: dataWithPhotos["title"],
                                      categoryName: favCategoryName[index]);
                                } else {
                                  //print("fav : " + favContent[index]);
                                  favContent[index]
                                      .toString()
                                      .replaceFirst("]", ",");
                                  //print("fav : " + favContent[index]);

                                  List<String> itemContent =
                                      favContent[index].toString().split(",");
                                  //print("itemFav: $itemContent");
                                  List<String> labelList = itemContent
                                      .map((content) => content
                                          .substring(0, content.indexOf(":"))
                                          .trim()
                                          .replaceAll("[", ""))
                                      .toList();
//                          print("labels: $labelList");

                                  List<String> valueList =
                                      favContent[index].toString().split(",");
                                  valueList = valueList
                                      .map((value) => value
                                          .substring(value.indexOf(":") + 1)
                                          .trim()
                                          .replaceAll("]", ""))
                                      .toList();
                                  //                        print("valueList: $valueList");
                                  return DisplayItemWithOutPhoto(
                                      itemContent: favContent[index],
                                      onFavScreen: true,
                                      onSearchScreen: false,
                                      labelList: labelList,
                                      valueList: valueList,
                                      categoryName: favCategoryName[index]);
                                }
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: favContent.length),
                      ]),
                    ),
                  )
                : Center(
                    child: Text("Empty",
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
          ),
        );
      },
    );
  }
}
