import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/my_provider.dart';

class ContainsImage extends StatelessWidget {
  const ContainsImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, val, child) => SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Text(
          "Contains Images",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        value: val.containsImage,
        onChanged: (value) => val.changeSwitch(value),
      ),
    );
  }
}