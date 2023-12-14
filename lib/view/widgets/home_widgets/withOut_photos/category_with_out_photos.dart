import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/home_widgets/withOut_photos/display_item_with_out_photo.dart';

class CategoryWithOutPhotos extends StatelessWidget {
  const CategoryWithOutPhotos(
      {super.key, required this.content, required this.categoryName});
  final String content;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final watchSql = context.watch<MySql>();
    if (content == "Empty") {
      return Center(
          child: Text(
        "Empty",
        style: Theme.of(context).textTheme.labelMedium,
      ));
    } else {
      //print(content);
      if (content != "") {
        List<String> valueList = watchSql.fetchValues(content);
        List<String> labelList = watchSql.fetchLabels(content);

        return ListView.separated(
          itemCount: valueList.length,
          itemBuilder: (context, index) {
            List<String> itemContent = valueList[index].split("\n");
            itemContent.removeLast();
            List<String> data = itemContent.map((val) {
              return val
                  .substring(val.indexOf(":"))
                  .replaceFirst(":", "")
                  .trim();
            }).toList();
            itemContent[0] = labelList[0] + itemContent[0];

            return DisplayItemWithOutPhoto(
              onFavScreen: false,
              onSearchScreen: false,
              labelList: labelList,
              valueList: data,
              itemContent: itemContent.toString(),
              categoryName: categoryName,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        );
      }
    }
    return Center(
      child: Text(
        "Empty",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
