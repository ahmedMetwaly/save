import 'package:flutter/material.dart';
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
        separatorBuilder: (ctxL, index) => const SizedBox(
          height: 15,
        ),
        itemCount: value.controllerNumbers,
        itemBuilder: ((ctxL, index) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
