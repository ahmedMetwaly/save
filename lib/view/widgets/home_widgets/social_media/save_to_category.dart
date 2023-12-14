import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/view/screens/home.dart';

import '../../../../controller/my_provider.dart';
import '../../../../model/cach_helper.dart';
import '../../../../model/database.dart';
import '../../components/input_field.dart';


class SaveToCategory extends StatelessWidget {
  const SaveToCategory({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController categoryNameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final makeProvider = context.watch<MyProvider>();
    final cachM = context.watch<CachHelper>();
    final cachR = context.read<CachHelper>();

    void insertToCategory() {
      Scaffold.of(context).showBottomSheet(
        (context) => Container(
          padding:
              const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 10),
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InputField(
                      controller: categoryNameController,
                      label: "Category name",
                      hint: "ex: technology",
                      withMaxLines: false),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                      controller: titleController,
                      label: "Title",
                      hint: "ex: labtobs",
                      withMaxLines: false),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<MySql>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await value
                              .insertCategory(
                            value.database,
                            context,
                            categoryName: categoryNameController.text,
                            fields: ["title","link"].toString(),
                            withImage: "false",
                            content:
                                "(title, link)(${titleController.text.trim()}, ${makeProvider.sharedData.trim()})",
                          )
                              .then((value) async {
                            categoryNameController.text = "";
                            await cachM.setPref(cachR.kIsFirstTime, false);
                            await cachR.loadPref();
                          }).then((value) {
                            makeProvider.sharedData = "";
                            Navigator.popAndPushNamed(context, Home.routeName);
                            return null;
                          });
                          makeProvider.restInputs();
                        }
                      },
                      child: const Text(
                          "Add"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: ()  {
        insertToCategory();
        //Navigator.of(context).pop();
        //Navigator.of(context).pushNamed(Home.routeName);
      },
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: Text(
            "Add Category",
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
