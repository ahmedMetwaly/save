import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:save/model/cash_helper.dart";
import "package:save/view/screens/add_category.dart";
import "package:save/view/screens/fav.dart";
import "../../screens/social_media/display_social_media.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CashHelper>(
      builder: (context, value, child) => SafeArea(
        child: Drawer(
          backgroundColor: Theme.of(context).canvasColor,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).indicatorColor,
                height: 180.h,
                width: double.maxFinite,
                margin: EdgeInsetsDirectional.only(bottom: 20.h),
                padding: EdgeInsets.all(20.w),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/saveAppIcon.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SwitchListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.brightness_6_sharp,
                      color: Theme.of(context).indicatorColor,
                      size: 30.sp,
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Text(
                      "Theme",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16.sp,
                          ),
                    ),
                  ],
                ),
                value: value.isDark!,
                onChanged: (val) {
                  value.setPref(value.kIsDark, val);
                  value.loadPref();
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                onTap: () =>
                    Navigator.of(context).pushNamed(AddCategory.routeName),
                leading: Icon(
                  Icons.note_add_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: 30.sp,
                ),
                title: Text(
                  "Add Category",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                onTap: () =>
                    Navigator.of(context).pushNamed(FavScreen.routeName),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30.sp,
                ),
                title: Text(
                  "Favourite",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                onTap: () => Navigator.of(context)
                    .pushNamed(DisplaySocialMedia.routeName),
                leading: CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/plateforms.png"),
                  radius: 18.r,
                ),
                title: Text(
                  "Social Media Data",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
