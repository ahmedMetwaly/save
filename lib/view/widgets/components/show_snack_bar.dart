import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showSnackBar(BuildContext context, {required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 900),
    content: Text(
      title,
      overflow: TextOverflow.clip,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
    ),
    showCloseIcon: true,
    closeIconColor: Theme.of(context).primaryColor,
    backgroundColor: Theme.of(context).indicatorColor,
  ));
}
