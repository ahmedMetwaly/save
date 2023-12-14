import 'package:flutter/material.dart';
import 'package:save/view/screens/home.dart';
import '../../screens/search.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    title: InkWell(
      onTap: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).indicatorColor,
            )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Search",
              style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                  fontSize: 18)),
          Icon(
            Icons.search,
            size: 28,
            color: Theme.of(context).primaryColor.withOpacity(.5),
          ),
        ]),
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon:const Icon(
          Icons.menu_rounded,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.home_rounded,
          ),
          onPressed: () =>
              Navigator.of(context).popAndPushNamed(Home.routeName),
        ),
      ),
      const SizedBox(width: 5,),
    ],
    backgroundColor: Theme.of(context).canvasColor,
    iconTheme: IconThemeData(
      color: Theme.of(context).primaryColor,
    ),
  );
}
