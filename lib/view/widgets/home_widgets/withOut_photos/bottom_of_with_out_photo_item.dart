import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../model/database.dart';

class ButtomOfWithOutPhotosItem extends StatelessWidget {
  const ButtomOfWithOutPhotosItem({
    super.key,
    required this.data,
    required this.categoryName,
  });

  final List data;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Consumer<MySql>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              borderRadius:  BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {

                    if (value.favList.any((favitem) {
                     
                      return favitem["content"]
                          .toString()
                          .contains(data.toString());
                    })) {
                      value.deleteFromFav(content: data.toString());
                    } else {
                     
                      value.insertToFav(context,
                          content: data.toString(), categoryName: categoryName);
                    }
                  },
                  icon: const Icon(Icons.favorite, size: 30),
                  color: value.favList.any((favitem) =>
                          favitem["content"].toString().contains(data[0]))
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                  splashRadius: 20.0),
              IconButton(
                  onPressed: () async {
                    try {
                      await Share.share(data
                          .toString()
                          .substring(1)
                          .replaceFirst("]", "")
                          .replaceFirst(", ", "\n"));
                    } catch (error) {
                      error;
                    }
                  },
                  icon: const Icon(Icons.share, size: 30),
                  color: Theme.of(context).primaryColor,
                  splashRadius: 20.0)
            ],
          ),
        );
      },
    );
  }
}
