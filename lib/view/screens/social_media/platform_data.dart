import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';
import 'package:save/view/widgets/home_widgets/social_media/display_platform_item.dart';

class PlatformData extends StatelessWidget {
  const PlatformData({super.key});
  static const routeName = "/platformData";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final make = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(args.toString().toUpperCase())),
      body: Consumer<MySql>(
        builder: (context, value, child) => RefreshIndicator(
          onRefresh: () {
            return make.execute();
          },
          child: SafeArea(
            child: value.platformData.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              child: SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: Center(
                                  child: Text(
                                    "Clear ${args.toString()}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ShowAlertDialog(
                                        title: "Clear ${args.toString()}",
                                        content:
                                            "Do you want to clear ${args.toString()} ?",
                                        onPressedOk: () => value
                                            .clearPlatform(
                                                platform: args.toString())
                                            .then((value) =>
                                                Navigator.of(context).pop()),
                                      );
                                    },
                                  )),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => DisplayPlatformItem(
                                onFavScreen: false,
                                onSearchScreen: false,
                                platformItem: value.platformData[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: value.platformData.length),
                        ],
                      ),
                    ),
                  )
                :  Center(
                    child: Text("Empty", style: Theme.of(context).textTheme.labelMedium,),
                  ),
          ),
        ),
      ),
    );
  }
}
