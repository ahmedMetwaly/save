import 'package:flutter/material.dart';

import 'package:save/view/widgets/components/my_drawer.dart';

import '../../screens/add_category.dart';

class AddDataForFirstTime extends StatelessWidget {
  const AddDataForFirstTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save"),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: const AddToFirstTimeBody(),
    );
  }
}

class AddToFirstTimeBody extends StatelessWidget {
  const AddToFirstTimeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Your First Category, please !",
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 40,
          ),
          Icon(
            Icons.arrow_downward_rounded,
            color: Theme.of(context).primaryColor,
            size: 90,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddCategory.routeName);
            },
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Add Category",
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
          ),
        ],
      ),
    );
  }
}
