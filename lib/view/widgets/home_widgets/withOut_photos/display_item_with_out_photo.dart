import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/database.dart';
import '../../../screens/make_edit.dart';
import '../../components/link_preview.dart';
import '../../components/show_alert_dialog.dart';
import 'bottom_of_with_out_photo_item.dart';

class DisplayItemWithOutPhoto extends StatelessWidget {
  const DisplayItemWithOutPhoto(
      {super.key,
      required this.itemContent,
      required this.categoryName,
      required this.labelList,
      required this.valueList,
      required this.onSearchScreen,
      required this.onFavScreen});
  final String itemContent;
  final List<String> labelList;
  final List<String> valueList;
  final String categoryName;
  final bool onSearchScreen;
  final bool onFavScreen;
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyProvider>();

    List data = itemContent.split(",");
    data = data
        .map((item) =>
            item.toString().replaceFirst("[", "").replaceFirst("]", "").trim())
        .toList();

    List urls = watch.fetchUrl(itemContent);

    return Consumer<MySql>(
      builder: (context, mySQL, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).indicatorColor.withOpacity(0.3),
          ),
          child: Column(
            children: [
              onSearchScreen
                  ? const SizedBox()
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
                                        itemContent: data.toString(),
                                        categoryName: categoryName,
                                        valueList: valueList,
                                      )),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          color: Theme.of(context).primaryColor,
                          iconSize: 30,
                        ),
                        onFavScreen
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ShowAlertDialog(
                                            title: "Delete",
                                            content:
                                                "Do want to delete ${valueList[0]} from $categoryName ?",
                                            onPressedOk: () {
                                              mySQL
                                                  .editContentOfWithOutPhoto(
                                                      categoryName:
                                                          categoryName,
                                                      itemContent: itemContent,
                                                      valueList: valueList,
                                                      labelList: labelList)
                                                  .then((value) {
                                                   List favContent= mySQL.favList.map((fav) => fav["content"]).toList(); 
                                                    if(favContent.contains(itemContent)){
                                                      mySQL.deleteFromFav(content: itemContent);
                                                    }
                                                    Navigator.of(context)
                                                          .pop();
                                                  });
                                            },
                                          ));

                                  // mySQL.deleteFromCategory(context);
                                },
                                icon: const Icon(Icons.delete),
                                color: Theme.of(context).primaryColor,
                                iconSize: 30,
                              ),
                      ],
                    ),
              ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, indx) {
                  for (int i = 0; i < urls.length; i++) {
                    if (urls.isNotEmpty && data[indx].contains(urls[i])) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Text(
                                "${data[indx].replaceAll(urls[i], "").trim()} ",
                                style: Theme.of(context).textTheme.labelMedium),
                            Expanded(child: LinkPreviewWidget(urlLink: urls[i])),
                          ],
                        ),
                      );
                    }
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: Text(data[indx],
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ],
                  );
                },
              ),
              ButtomOfWithOutPhotosItem(
                data: data,
                categoryName: categoryName,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
