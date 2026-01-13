import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:save/view/widgets/components/my_drawer.dart';

import '../../screens/add_category.dart';

class AddDataForFirstTime extends StatelessWidget {
  const AddDataForFirstTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save"),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: const AddToFirstTimeBody(),
    );
  }
}

class AddToFirstTimeBody extends StatelessWidget {
  const AddToFirstTimeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Your First Category, please !",
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.clip,
          ),
          SizedBox(
            height: 40.h,
          ),
          Icon(
            Icons.arrow_downward_rounded,
            color: Theme.of(context).primaryColor,
            size: 90.sp,
          ),
          SizedBox(
            height: 40.h,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddCategory.routeName);
            },
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.w),
                child: Text(
                  "Add Category",
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
          ),
        ],
      ),
    );
  }
}
