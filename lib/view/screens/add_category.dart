import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/cach_helper.dart';
import 'package:save/model/database.dart';
import '../widgets/add_category_widgtes/contains_image.dart';
import '../widgets/add_category_widgtes/fields.dart';
import '../widgets/add_category_widgtes/number_of_fields.dart';
import '../widgets/components/input_field.dart';
import 'home.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});
  static const routeName = "/add_category";

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController categoryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  controller: categoryName,
                  label: "Category Name",
                  hint: "ex: Ai tools",
                  withMaxLines: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                const ContainsImage(),
                const NumberOfFileds(),
                const SizedBox(height: 15),
                const Fields(),
                const SizedBox(height: 15),
                Consumer<MyProvider>(
                  builder: (ctxE, value, child) {
                    final read = context.read<MySql>();
                    final make = context.watch<MySql>();
                    final cachM = context.watch<CachHelper>();
                    final cachR = context.read<CachHelper>();
                    return ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          value.extractTextFromControllers(value.controllers);
                          await make
                              .insertCategory(
                            read.database,
                            context,
                            categoryName: categoryName.text,
                            fields: value.fieldsName.toString(),
                            withImage: value.containsImage.toString(),
                            content: "Empty",
                          )
                              .then((val) async {
                            categoryName.text = "";
                            await cachM.setPref(cachR.kIsFirstTime, false);
                            await cachR.loadPref();
                           // ignore: use_build_context_synchronously
                           Navigator.of(context).popAndPushNamed(Home.routeName);
                          });
                          value.restInputs();
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Add Category",
                            style: Theme.of(ctxE).textTheme.bodyMedium,
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
