import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/cash_helper.dart';
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
        padding: EdgeInsets.all(15.0.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                InputField(
                  controller: categoryName,
                  label: "Category Name",
                  hint: "ex: Ai tools",
                  withMaxLines: false,
                ),
                SizedBox(
                  height: 15.h,
                ),
                const ContainsImage(),
                const NumberOfFileds(),
                SizedBox(height: 15.h),
                const Fields(),
                SizedBox(height: 15.h),
                Consumer<MyProvider>(
                  builder: (ctxE, value, child) {
                    final read = context.read<MySql>();
                    final make = context.watch<MySql>();
                    final cachM = context.watch<CashHelper>();
                    final cachR = context.read<CashHelper>();
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
                            Navigator.of(context)
                                .popAndPushNamed(Home.routeName);
                          });
                          value.restInputs();
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.w),
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
