import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/my_provider.dart';
import '../components/input_field.dart';

class Fields extends StatelessWidget {
  const Fields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, value, child) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (ctxL, index) => SizedBox(
          height: 15.h,
        ),
        itemCount: value.controllerNumbers,
        itemBuilder: ((ctxL, index) => Padding(
              padding: EdgeInsets.only(top: 8.0.h),
              child: InputField(
                  controller: value.controllers[index],
                  label: "Field ${index + 1} Title",
                  hint: "ex: title",
                  withMaxLines: false),
            )),
      ),
    );
  }
}
