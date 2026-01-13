import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../model/database.dart';
import '../../components/input_field.dart';

class EditPlatformItem extends StatelessWidget {
  const EditPlatformItem({
    super.key,
    required this.platformItem,
  });

  final Map platformItem;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    return Consumer<MySql>(
      builder: (context, value, child) => IconButton(
          onPressed: () {
            Scaffold.of(context).showBottomSheet((context) => Container(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 10, right: 10, bottom: 10),
                  height: 0.4.sh,
                  decoration: BoxDecoration(
                    color: Theme.of(context).indicatorColor.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.r),
                      topRight: Radius.circular(45.r),
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InputField(
                              controller: controller,
                              label: "New value",
                              hint: "ex: Ai tool",
                              withMaxLines: false),
                          SizedBox(
                            height: 20.h,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                value
                                    .updateSocialMediaItem(
                                        id: platformItem["id"],
                                        title: controller.text.trim())
                                    .then((val) {
                                  List favContent = value.favList
                                      .map((favItem) => favItem["content"])
                                      .toList();
                                  String oldContent = platformItem
                                      .toString()
                                      .replaceFirst("{", "[")
                                      .replaceFirst("}", "]");
                                  Map newContent = {
                                    "id": platformItem["id"],
                                    "platform": platformItem["platform"],
                                    "title": controller.text.trim(),
                                    "link": platformItem["link"]
                                  };
                                  if (favContent.contains(oldContent)) {
                                    value.updateFavItem(
                                        newContent: newContent
                                            .toString()
                                            .replaceFirst("{", "[")
                                            .replaceFirst("}", "]"),
                                        oldContent: oldContent);
                                  }

                                  return value
                                      .getPlatform(
                                          platform: platformItem["platform"])
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                });
                              }
                            },
                            child: const Text("Aplly Edit"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
          icon: Icon(
            Icons.edit,
            color: Theme.of(context).primaryColor,
          ),
          splashRadius: 20.r),
    );
  }
}
