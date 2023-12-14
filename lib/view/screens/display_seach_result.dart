import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/home_widgets/social_media/display_platform_item.dart';
import 'package:save/view/widgets/home_widgets/withOut_photos/display_item_with_out_photo.dart';

import '../widgets/home_widgets/with_photos/display_item_with_photos.dart';

class DisplaySearchResult extends StatelessWidget {
  const DisplaySearchResult({
    super.key,
    required this.resultContent,
  });
  final Map resultContent;
  static const routeName = "/searchResult";

  @override
  Widget build(BuildContext context) {
    return Consumer<MySql>(
      builder: (context, value, child) {
        bool withImage = false;
        Map dataToDisplay = {};
        String categoryName = resultContent.keys.first;
        bool isSocialMediaContent = false;
        try {
          value.socialMedia.any((element) =>
              element["id"] == resultContent[resultContent.keys.first]["id"]);
          isSocialMediaContent = true;
        } catch (error) {
          isSocialMediaContent = false;
          value.data.map((category) {
            String content = resultContent.values.first;
            if (category["categoryName"] == categoryName) {
              if (category["content"].toString().contains(content) &&
                  category["withImage"] == "true") {
                // print("contains images");
                withImage = true;
                Map contentData = value.fetchDataToDisplay(context, content);
                String contentTitle = contentData["title"];
                String spContent = value.selectSpecificContent(
                    categoryName: categoryName, title: contentTitle);
                int endIndex = spContent.indexOf("]");
                String result = spContent.substring(0, endIndex);
                dataToDisplay =
                    value.fetchDataToDisplay(context, result.toString());
              } else {
                withImage = false;
              }
            }
          }).toList();
        }
        return Scaffold(
            appBar: AppBar(title: const Text('Search Result')),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isSocialMediaContent
                              ? DisplayPlatformItem(
                                  onSearchScreen: true,
                                  onFavScreen: false,
                                  platformItem:
                                      resultContent[resultContent.keys.first])
                              : withImage
                                  ? DisplayItemWithPhotos(
                                      fromSearchScreen: true,
                                      favScreen: false,
                                      labelList: dataToDisplay["labelsList"],
                                      imagesList: dataToDisplay["imagesList"],
                                      valuesList: dataToDisplay["valuesList"],
                                      urlsList: dataToDisplay["urlsList"],
                                      title: dataToDisplay["title"],
                                      categoryName: categoryName)
                                  : DisplayItemWithOutPhoto(
                                      onSearchScreen: true,
                                      onFavScreen: false,
                                      itemContent: resultContent.values.first,
                                      labelList: const [],
                                      valueList: const [],
                                      categoryName: categoryName,
                                    ) /* Center(child: Text("withoutImage"),) */
                        ]),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
