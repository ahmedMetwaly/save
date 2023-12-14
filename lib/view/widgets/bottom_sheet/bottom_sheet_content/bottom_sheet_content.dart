import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/bottom_sheet/bottom_sheet_content/select_category.dart';
import 'package:save/view/widgets/components/input_field.dart';

import '../bottom_sheet_head/bottom_sheet_head.dart';
import 'display_add_photos.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    //final read = context.read<MyProvider>();
    final readSql = context.read<MySql>();
    return Consumer<MyProvider>(
      builder: (context, value, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BottomSheetHead(),
          const SizedBox(
            height: 15,
          ),
          value.dropDownButtonItem == null
              ? const SelectCategory()
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(15),
                            itemBuilder: (context, index) {
                              return InputField(
                                  controller: readSql.fieldsController[index],
                                  label: readSql.categoryFields[index]
                                      .toString()
                                      .trim(),
                                  hint: "ex: Title",
                                  withMaxLines: false);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: readSql.categoryFields.length),
                        readSql.categoryDetails["withImage"] == "true"
                            ? const DisplayAddPhotos()
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

