import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:save/model/cach_helper.dart";
import "package:save/view/screens/add_category.dart";
import "package:save/view/screens/fav.dart";
import "../../screens/social_media/display_social_media.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CachHelper>(
      builder: (context, value, child) => SafeArea(
        child: Drawer(
          backgroundColor: Theme.of(context).canvasColor,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).indicatorColor,
                height: 180,
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/saveAppIcon.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.brightness_6_sharp,
                      color: Theme.of(context).indicatorColor,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Theme",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                value: value.isDark!,
                onChanged: (val) {
                  value.setPref(value.kIsDark, val);
                  value.loadPref();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () =>
                    Navigator.of(context).pushNamed(AddCategory.routeName),
                leading: Icon(
                  Icons.note_add_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: 30,
                ),
                title: const Text(
                  "Add Category",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () =>
                    Navigator.of(context).pushNamed(FavScreen.routeName),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                ),
                title: const Text(
                  "Favourite",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () => Navigator.of(context)
                    .pushNamed(DisplaySocialMedia.routeName),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/plateforms.png"),
                  radius: 18,
                ),
                title: const Text(
                  "Social Media Data",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
