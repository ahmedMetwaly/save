import 'package:flutter/material.dart';

import '../../widgets/home_widgets/social_media/platform_button.dart';

class DisplaySocialMedia extends StatelessWidget {
  const DisplaySocialMedia({super.key});
  static const String routeName = "/displaySocialMedia";
  @override
  Widget build(BuildContext context) {
      List <String> platforms = ["facebook","instagram","twitter","snapchat","tiktok","youtube","chrome","linkedin"];

    return Scaffold(
      appBar: AppBar(title: const Text('SocialMedia Data')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 15),
          
          itemCount: platforms.length,
          itemBuilder: (context, index) => PlatformButton(
            platform: platforms[index],
            appIcon: "assets/images/${platforms[index]}.png",
            display: "yes",
          ),
        
        separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}