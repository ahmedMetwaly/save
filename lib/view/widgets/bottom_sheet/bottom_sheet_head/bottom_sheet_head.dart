import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save/view/widgets/bottom_sheet/bottom_sheet_head/drop_button.dart';

class BottomSheetHead extends StatelessWidget {
  const BottomSheetHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("New"),
          SizedBox(
            width: 15.w,
          ),
          const DropButton(),
          //SaveButton(),
        ],
      ),
    );
  }
}
