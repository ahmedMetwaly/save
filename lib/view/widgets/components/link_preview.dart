import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'go_to_link.dart';
import 'infinite_animation.dart';

class LinkPreviewWidget extends StatelessWidget {
  const LinkPreviewWidget({super.key, required this.urlLink});
  final String urlLink;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    List url = provider.fetchUrl(urlLink);
    
    return Consumer<MyProvider>(builder: (context, value, child) {
      value.execute();
      if (value.isConnected) {
        try {
          return AnyLinkPreview(
            link: url[0],
            backgroundColor: Theme.of(context).canvasColor.withOpacity(0.5),
            titleStyle: Theme.of(context).textTheme.labelMedium,
            cache: const Duration(hours: 1),
            removeElevation: true,
            displayDirection: UIDirection.uiDirectionHorizontal,
            previewHeight: (MediaQuery.of(context).size.height) * 0.2,
            urlLaunchMode: LaunchMode.externalApplication,
            bodyStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color:Theme.of(context).textTheme.labelMedium!.color!.withOpacity(0.7) ,fontSize: 14),
            bodyMaxLines: 5,
            placeholderWidget:  InfiniteAnimation(child: Image.asset("assets/images/saveAppIcon.png",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,)),
            //errorImage: "https://drive.google.com/file/d/1Lzp0x3OVOcQtEKsfvij9qXmIAnCnYPe8/view?usp=sharing",
            errorBody: "Oops",
            errorTitle: "Plaese check your connection",
            errorWidget: Container(
              color: Colors.white,
            ),
          );
        } catch (error) {
          //print(error);
          return GoToLink(url: url[0]);
        }
      } else {
        return GoToLink(url: url[0]);
      }
    });
  }
}
