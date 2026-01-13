import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_upward_rounded,
            size: 50.sp,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Select category you want to add on it, Please!",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 20.sp,
                  overflow: TextOverflow.clip,
                ),
          ),
        ],
      ),
    );
  }
}
