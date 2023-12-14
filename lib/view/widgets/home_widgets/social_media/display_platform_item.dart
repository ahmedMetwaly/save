import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';
import '../../components/link_preview.dart';
import '../withOut_photos/bottom_of_with_out_photo_item.dart';
import 'edit_platform_item.dart';

class DisplayPlatformItem extends StatelessWidget {
  const DisplayPlatformItem(
      {super.key, required this.platformItem, required this.onSearchScreen, required this.onFavScreen});
  final Map platformItem;
  final bool onSearchScreen;
  final bool onFavScreen;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(20),
      child: Consumer<MySql>(
        builder: (context, value, child) => Container(
          padding: const EdgeInsets.all(15.0),
               color:Theme.of(context).indicatorColor.withOpacity(0.3),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              onSearchScreen
                  ? const SizedBox(
                      height: 15,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EditPlatformItem(platformItem: platformItem),
                        onFavScreen?const SizedBox(): IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => ShowAlertDialog(
                                        title: "Delete",
                                        content:
                                            'Do you want to delete ${platformItem["title"]} ?',
                                        onPressedOk: () {
                                          value
                                              .deleteSocialMediaItem(
                                                  id: platformItem["id"])
                                              .then((val) => value.getPlatform(
                                                  platform:
                                                      platformItem["platform"]))
                                              .then(
                                                (value) =>
                                                    Navigator.of(context).pop(),
                                              );
                                        },
                                      ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).primaryColor,
                            ),
                            splashRadius: 20),
                      ],
                    ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.labelMedium??const TextStyle(),
                child: Row(
                  children: [
                    const Text(
                      "Title : ",
                    ),
                    Expanded(
                      child: Text(
                        platformItem["title"],
                        overflow: platformItem["title"].length > 15
                            ? TextOverflow.ellipsis
                            : TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            LinkPreviewWidget(urlLink: platformItem["link"]),
              ButtomOfWithOutPhotosItem(
                data: [
                  "id: ${platformItem["id"]}",
                  "platform: ${platformItem["platform"]}",
                  "title: ${platformItem["title"]}",
                  "link: ${platformItem["link"]}"
                ],
                categoryName: platformItem["platform"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

