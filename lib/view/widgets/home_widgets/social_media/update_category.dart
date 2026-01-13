import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controller/my_provider.dart';
import '../../../../model/database.dart';
import '../../../screens/home.dart';
import '../../components/input_field.dart';
import '../../components/show_snack_bar.dart';

class UpdateCategoryButton extends StatelessWidget {
  const UpdateCategoryButton({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final makeProvider = context.watch<MyProvider>();
    final makeSQL = context.watch<MySql>();

    void updateCategory() {
      Scaffold.of(context).showBottomSheet(
        (context) => Container(
          padding:
              const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 10),
          height: 0.4.sh,
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.r),
              topRight: Radius.circular(45.r),
            ),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InputField(
                      controller: titleController,
                      label: "Title",
                      hint: "",
                      withMaxLines: false),
                  SizedBox(
                    height: 20.h,
                  ),
                  Consumer<MySql>(
                    builder: (context, mySQL, child) => ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          mySQL
                              .updateCategory(
                                  context: context,
                                  db: mySQL.database,
                                  content:
                                      "(title, link)(${titleController.text.trim()}, ${makeProvider.sharedData.trim()})",
                                  categoryName: categoryName)
                              .then((value) {
                            makeProvider.sharedData = "";
                            showSnackBar(context,
                                title:
                                    "${titleController.text.toUpperCase()} Added to $categoryName");
                            Navigator.of(context)
                                .popAndPushNamed(Home.routeName);
                          });
                          //  print( categories[index]["content"]);
                        }
                      },
                      child: Text("Add to $categoryName"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return ListTile(
      title: Text(
        categoryName.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium,
      ),
      leading: Image.asset(
        "assets/images/saveAppIcon.png",
        fit: BoxFit.cover,
      ),
      onTap: () {
        makeSQL.selectSpecificCategory(categoryName: categoryName);
        //    String oldContent = makeSQL.categoryContent;
//      print("oldcontetn : $oldContent");
        updateCategory();
      },
    );
  }
}
