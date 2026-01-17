import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/database.dart';
import '../widgets/components/input_field.dart';

class Edit extends StatelessWidget {
  const Edit({
    super.key,
    required this.labelList,
    required this.categoryName,
    this.title,
    required this.valueList,
    this.itemContent,
  });
  final List<String> labelList;
  final List<String> valueList;
  final String categoryName;
  final String? title;
  final String? itemContent;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    List<TextEditingController> controllers =
        List.generate(labelList.length, (index) => TextEditingController());
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].text = valueList[i];
    }
    makeEdit(BuildContext context) {
      final value = Provider.of<MySql>(context, listen: false);
      List categories = value.data;
      if (categories.any((categoryItem) =>
          categoryItem["categoryName"] == categoryName &&
          categoryItem["withImage"] == "true")) {
        if (formKey.currentState!.validate()) {
          value
              .editContentOfWithImage(
                  categoryName: categoryName,
                  title: title ?? "",
                  valueList: valueList,
                  controllers: controllers)
              .then((value) => Navigator.of(context).pop());
        }
      } else {
        if (formKey.currentState!.validate()) {
          value
              .editContentOfWithOutPhoto(
                  categoryName: categoryName,
                  itemContent: itemContent ?? "",
                  valueList: valueList,
                  labelList: labelList,
                  newValue: controllers)
              .then((val) {
            Navigator.of(context).pop();
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Edit item")),
      body: Padding(
        padding: EdgeInsets.all(15.0.w),
        child: Consumer<MySql>(
          builder: (context, value, child) {
            return Center(
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: labelList.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          // controllers[index].text = valueList[index];

                          return Row(
                            children: [
                              Text(
                                "${labelList[index].trim()} : ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Expanded(
                                child: InputField(
                                    controller: controllers[index],
                                    label: "New value",
                                    hint: "",
                                    withMaxLines: false),
                              ),
                            ],
                          );
                        },
                      ),
                      const Divider(),
                      ElevatedButton(
                          onPressed: () {
                            makeEdit(context);
                          },
                          child: Text(
                            "Save",
                            // style: TextStyle(fontSize: 18.sp),
                          )),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
