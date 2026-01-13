import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 0.3.sh,
        ),
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          value: 99,
          semanticsLabel: "Loading",
        ),
        SizedBox(
          height: 15.h,
        ),
        const Text("Loading")
      ],
    );
  }
}
