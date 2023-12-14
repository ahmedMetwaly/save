import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/input_field.dart';

import '../../../screens/home.dart';
import '../../../screens/social_media/platform_data.dart';

class PlatformButton extends StatelessWidget {
  const PlatformButton({super.key, required this.platform, required this.appIcon, this.display ="No"});
  final String platform;
  final String appIcon;
  final String display;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final read = context.read<MyProvider>();
    final make = context.watch<MySql>();

    void insertToPlatform(){
      Scaffold.of(context).showBottomSheet((context) => Container(
        padding: const EdgeInsets.only(top : 20.0 , left: 10, right: 10, bottom: 10),
        height: MediaQuery.of(context).size.height*0.4,
        decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
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
                    label: "Title",
                    hint: "jobs",
                    withMaxLines: false),
                    const SizedBox(height: 20,),
                Consumer<MySql>(
                  builder: (context, value, child) => ElevatedButton(
                    
                    onPressed: () async{
                      if (formKey.currentState!.validate()) {

                       await value
                            .insertToSocialMedia(context,
                                platform: platform,
                                title: controller.text,
                                link: read.sharedData)
                            .then(
                          (value) {
                            Navigator.pop(context);
                        read.sharedData="";
                        Navigator.of(context).pushNamed(Home.routeName);
                          },
                        );
                      }
                    },
                    child: Text("Add to ${platform.toUpperCase()}"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    void displayData(String platform) async{

     await make.getPlatform(platform:platform);
     // ignore: use_build_context_synchronously
     Navigator.of(context).pushNamed(PlatformData.routeName,arguments: platform);
     //print(make.platformData);
    }

    return ListTile(
      leading: Image.asset(appIcon, fit: BoxFit.cover,),
      title: Text(
        "${platform.toUpperCase()} links",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onTap: () => display=="yes"?displayData(platform): insertToPlatform(),
  
    );
  }
}
