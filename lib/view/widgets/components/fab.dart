import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/show_snack_bar.dart';
import '../../../controller/my_provider.dart';

class FAB extends StatefulWidget {
  const FAB({super.key});

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context,listen: false);

    final mySql = Provider.of<MySql>(context,listen: false);
    return FloatingActionButton.extended(
      label: Row(
        children: [
          Text(provider.fabTitle),
          Icon(
            provider.fabIcon,
            size: 30,
          ),
        ],
      ),
      onPressed: () {
        if (provider.fabIcon == Icons.save_as_rounded &&
            provider.formKey.currentState!.validate()) {
          if (mySql.categoryDetails["withImage"] == "true" &&
              provider.files.isNotEmpty) {
            mySql
                .updateCategory(
                  context: context,
                    db: mySql.database,
                    content:
                        "${mySql.categoryFields.map((e) => e.toString())}${mySql.fieldsController.map((e) => e.text)},${provider.files}",
                    categoryName: mySql.categoryDetails["categoryName"])
                .then((value) {                  
                });
          } else if (mySql.categoryDetails["withImage"] == "false") {
            mySql
                .updateCategory(
                  context: context,
                    db: mySql.database,
                    content:
                        "${mySql.categoryFields.map((e) => e.toString().trim())}${mySql.fieldsController.map((e) => e.text.trim())}",
                    categoryName: mySql.categoryDetails["categoryName"])
                .then((value) {
/*               showSnackBar(context,
                  title:
                      "${mySql.fieldsController[0].text} Added to ${read.dropDownButtonItem}");

              provider.toggleBottomSheet(context); */
            });
          } else {
            showSnackBar(context, title: "Select at least 1 photo, Please!");
            //  print("add Images");
          }
        } else if (provider.fabIcon == Icons.add) {
          provider.toggleBottomSheet(context);
        }
      },
    );
  }
}
