import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import 'package:save/view/screens/display_seach_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const routeName = "/searchScreen";
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  List<String> filteredItems = [];
  String _query = '';
  List<String> items = [];
  // Map allValues = {};
  void search() {
    return setState(
      () {
        _query = controller.value.text;
        filteredItems = items
            .where(
              (item) => item.toLowerCase().trim().contains(
                    controller.value.text.toLowerCase().trim(),
                  ),
            )
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final watchSql = context.watch<MySql>();
    final readSql = context.read<MySql>();
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.name,
            autofocus: true,
            style: TextStyle(color: Theme.of(context).primaryColor),
            onChanged: (value) {
              watchSql.fetchSearchData();
              List keys = readSql.searchOn.keys.toList();
              items = keys.map((key) => key.toString()).toList();
              search();
            },
            decoration: const InputDecoration(
              hintText: "categoryName:field",
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.labelMedium??const TextStyle(),
        child: SafeArea(
          child: filteredItems.isEmpty || _query == ""
              ? const Center(child: Text("No results found"))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredItems[index],
                       style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.clip,
                      ),
                      onTap: () {
                        String categoryName = filteredItems[index]
                            .substring(0, filteredItems[index].indexOf(":"));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplaySearchResult(
                                  resultContent: {
                                    categoryName:
                                        readSql.searchOn[filteredItems[index]]
                                  }),
                            ));
                      },
                    );
                  },
                  itemCount: filteredItems.length,
                ),
        ),
      ),
    );
  }
}
