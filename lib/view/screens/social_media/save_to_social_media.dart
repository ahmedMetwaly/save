import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/view/screens/home.dart';
import 'package:save/view/widgets/home_widgets/social_media/platform_button.dart';
import '../../../model/database.dart';
import '../../widgets/home_widgets/social_media/save_to_category.dart';
import '../../widgets/home_widgets/social_media/update_category.dart';

class SaveToSocialMedia extends StatelessWidget {
  const SaveToSocialMedia({super.key});
  static const String routeName = "/SharedDataScreen";

  @override
  Widget build(BuildContext context) {
    final makeSQL = context.watch<MySql>();
    List<String> platforms = [
      "facebook",
      "instagram",
      "twitter",
      "snapchat",
      "tiktok",
      "youtube",
      "chrome",
      "linkedin",
    ];
    List categories = makeSQL.data
        .where((category) => category["fields"] == "[title, link]")
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Save to...'),
        leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushNamed(Home.routeName)),
       // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Expanded(
              child: ListView(children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => UpdateCategoryButton(
                    categoryName: categories[index]["categoryName"],
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
                const Divider(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: platforms.length,
                  itemBuilder: (context, index) => PlatformButton(
                    platform: platforms[index],
                    appIcon: "assets/images/${platforms[index]}.png",
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ]),
            ),
            const SizedBox(
              height: 15,
            ),
            const SaveToCategory(),
          ]),
        ),
      ),
    );
  }
}
