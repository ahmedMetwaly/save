import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save/view/screens/home.dart';
import '../../screens/search.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    title: InkWell(
      onTap: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Theme.of(context).indicatorColor,
            )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Search",
              style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                  fontSize: 18.sp)),
          Icon(
            Icons.search,
            size: 28.sp,
            color: Theme.of(context).primaryColor.withOpacity(.5),
          ),
        ]),
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.menu_rounded,
          size: 24.sp,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.home_rounded,
            size: 24.sp,
          ),
          onPressed: () =>
              Navigator.of(context).popAndPushNamed(Home.routeName),
        ),
      ),
      SizedBox(
        width: 5.w,
      ),
    ],
    backgroundColor: Theme.of(context).canvasColor,
    iconTheme: IconThemeData(
      color: Theme.of(context).primaryColor,
      size: 24.sp,
    ),
  );
}
