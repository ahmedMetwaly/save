import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/screens/make_edit.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';
import 'item_content/buttom_of_item.dart';
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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              fromSearchScreen
                  ? const SizedBox(
                      height: 15,
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
                          iconSize: 30,
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
                                color: Theme.of(context).primaryColor,
                                iconSize: 30,
                              ),
                      ],
                    ),
              HeadOfItem(
                  labelList: labelList, urls: urlsList, valuesList: valuesList),
              const SizedBox(height: 15),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DisplayPhotos(
                        imagesList: imagesList,
                        title: title,
                        categoryName: categoryName),
                    const SizedBox(width: 10),
                    AddPhoto(title: title, categoryName: categoryName),
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
