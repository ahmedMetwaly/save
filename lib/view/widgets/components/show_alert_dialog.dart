import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedOk,
  });

  final String title;
  final String content;
  final Function onPressedOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        content,
        style: TextStyle(fontSize: 16.sp),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 14.sp),
            )),
        TextButton(
            onPressed: () => onPressedOk(),
            child: Text(
              "Ok",
              style: TextStyle(fontSize: 14.sp),
            )),
      ],
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.sp),
          ),
          Divider(
            color: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
