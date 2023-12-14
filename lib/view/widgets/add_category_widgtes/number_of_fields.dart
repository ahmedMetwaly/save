import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/my_provider.dart';

class NumberOfFileds extends StatelessWidget {
  const NumberOfFileds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Number of Fields",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 20),
          ),
          IconButton(
            onPressed: () => value.changeControllerNumbers(operation: "add"),
            icon: Icon(
              Icons.add_circle_outline_outlined,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text("${value.controllerNumbers}",style: Theme.of(context)
                .textTheme
                .labelMedium,),
          IconButton(
            onPressed: () => value.changeControllerNumbers(operation: "minus"),
            icon: Icon(
              Icons.do_not_disturb_on_outlined,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
