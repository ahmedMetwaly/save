// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';
import 'package:save/view/widgets/components/show_snack_bar.dart';
import 'package:sqflite/sqflite.dart';

class MySql with ChangeNotifier {
  //bool isFirstTime = true;
  late Database database;
  List<Map> data = [];
  Future<void> openDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = '${databasesPath}save.db';
    // open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db
            .execute(
                'CREATE TABLE categories (categoryName TEXT PRIMARY KEY, fields TEXT, withImage TEXT, content TEXT)')
            .then((value) {
          value;
        } // print("database is created "),
                ).catchError(
          (error) => error,
        );
        await db
            .execute(
                'CREATE TABLE fav (id INTEGER PRIMARY KEY, categoryName TEXT, content TEXT)')
            .then((value) {
          value;
        }).catchError(
          (error) => error,
        );

        await db
            .execute(
                'CREATE TABLE socialMedia (id INTEGER PRIMARY KEY, platform TEXT, title TEXT, link TEXT)')
            .then((value) {
          value;
        }).catchError(
          (error) => error,
        );
      },
      onOpen: (db) async {
        await getData(db);
      },
    );
  }

  Future getData(Database db) async {
    await db.rawQuery("SELECT * FROM categories").then((value) {
      data = value;
      getFav(db);
      getSocialMediaData(db);
      notifyListeners();

     // print("data is : $data");
    }).catchError((error) => error);
  }

  Future insertCategory(Database db, BuildContext context,
      {required String categoryName,
      required String fields,
      required String withImage,
      required String content}) async {
    try {
      await db.transaction((txn) => txn.rawInsert(
              "INSERT INTO categories(categoryName , fields , withImage , content) VALUES(?, ?, ?, ?)",
              [categoryName, fields, withImage, content]).then((value) {
            notifyListeners();
            getData(db).then((value) {
              showSnackBar(context, title: "$categoryName Added");
              Navigator.of(context).pop();
            });
          }).catchError((error) => error));
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Warnning"),
                  Divider(),
                ],
              ),
              content: const Text(
                'This Category is Found, please change the name of category',
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok")),
              ],
            );
          });
      // print("error $error");
    }
  }

  Future delteCategory(BuildContext context,
      {required String categoryName}) async {
    showDialog(
        context: context,
        builder: (context) {
          return ShowAlertDialog(
            title: "Delete",
            content: 'Do you want to delete $categoryName ?',
            onPressedOk: () async {
              await database.rawDelete('DELETE FROM fav WHERE categoryName = ?',
                      [categoryName]).then((value) => getFav(database));
              await database
                  .rawDelete('DELETE FROM categories WHERE categoryName = ?',
                      [categoryName])
                  .then((value) => getData(database))
                  .then((value) => Navigator.of(context).pop());
            },
          );
        });
  }

  List<Map> favList = [];
  Future getFav(Database db) async {
    await db.rawQuery("SELECT * FROM fav").then((value) {
      favList = value;
      //print(favList);
      notifyListeners();
      // print("fav is got");
    }).catchError((error) => error);
  }

  Future insertToFav(BuildContext context,
      {required String content, required String categoryName}) async {
    List favContent = favList.map((favItem) => favItem["content"]).toList();
    if (favContent.contains(content)) {
      showSnackBar(context, title: "This item ia already in favourite");
    } else {
      await database.transaction((txn) => txn.rawInsert(
              "INSERT INTO fav(categoryName,content) VALUES(?,?)",
              [categoryName, content]).then((value) {
            notifyListeners();
            getFav(database).then((value) {
              showSnackBar(context, title: "Added To Favourite");
            });
          }).catchError((error) => error));
    }
  }

  List<Map> socialMedia = [];
  Future getSocialMediaData(Database db) async {
    await db.rawQuery("SELECT * FROM socialMedia").then((value) {
      socialMedia = value;
      notifyListeners();
      // print("social media data : $socialMedia");
    }).catchError((error) => error);
  }

  Future deleteFromFav({required String content}) async {
    await database.rawDelete('DELETE FROM fav WHERE content = ?',
        [content]).then((value) => getFav(database));
  }

  Future updateFavItem(
      {required String newContent, required String oldContent}) async {
    await database
        .rawUpdate("UPDATE fav SET content = ? WHERE content = ?",
            [newContent, oldContent])
        .then((value) => getFav(database))
        .catchError((error) => error);
  }

  Future clearFav(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return ShowAlertDialog(
          title: "Clear Favourite",
          content: "Do you want to clear favourites ?",
          onPressedOk: () async {
            await database
                .rawQuery("DELETE FROM fav")
                .then((value) => Navigator.of(context).pop())
                .then((value) {
              favList = [];
              notifyListeners();
            });
          },
        );
      },
    );
  }

  Future insertToSocialMedia(BuildContext context,
      {required String platform,
      required String title,
      required String link}) async {
    await database.transaction((txn) => txn.rawInsert(
            "INSERT INTO socialMedia(platform,title,link) VALUES(?,?,?)",
            [platform, title, link]).then((value) {
          notifyListeners();
          getSocialMediaData(database).then((value) {
            showSnackBar(context, title: "Added To $platform");
            //print(socialMedia);
            //  print(
            //    "category $categoryName is inserted \n Now database is $data");
          });
        }).catchError((error) => error));
  }

  Future deleteSocialMediaItem({required int id}) async {
    await database.rawDelete('DELETE FROM socialMedia WHERE id = ?', [id]).then(
        (value) => getSocialMediaData(database));
  }

  Future updateSocialMediaItem({required int id, required String title}) async {
    await database
        .rawUpdate("UPDATE socialMedia SET title = ? WHERE id = ?", [title, id])
        .then((value) => getSocialMediaData(database))
        .onError((error, stackTrace) => error);
  }

  List<Map> platformData = [];
  Future getPlatform({required String platform}) async {
    await database.rawQuery("SELECT * FROM socialMedia WHERE platform = ?",
        [platform]).then((value) {
      platformData = value;
      getSocialMediaData(database);
      notifyListeners();
    });
  }

  Future clearPlatform({required String platform}) async {
    await database
        .rawDelete('DELETE FROM socialMedia WHERE platform = ?', [platform])
        .then((value) => getPlatform(platform: platform))
        .catchError((error) => error);
  }

  Future updateCategory(
      {required String content,
      required String categoryName,
      required Database db,
      required BuildContext context}) async {
    final make = Provider.of<MyProvider>(context, listen: false);
    if (categoryDetails["withImage"] == "true") {
      String contentValue = "";
      bool isFound = false;
      List checkedValues = [];
      if (categoryContent != "Empty" &&
          categoryContent != "" &&
          categoryContent != null) {
        List<String> contentList = categoryContent.split("]");
        contentList.removeLast();
        for (int i = 0; i < contentList.length; i++) {
          Map<String, dynamic> data =
              fetchDataToDisplay(context, contentList[i]);
          checkedValues.add(data["valuesList"][0]);
        }
        List<String> newContentList = content.split("]");
        newContentList.removeLast();

        for (int i = 0; i < newContentList.length; i++) {
          Map<String, dynamic> data =
              fetchDataToDisplay(context, newContentList[i]);
          contentValue = data["valuesList"][0];
        }
        for (int i = 0; i < checkedValues.length; i++) {
          if (checkedValues[i] == contentValue) {
            isFound = true;
            break;
          }
        }
      }

      if (isFound == false) {
        String allContent =
            categoryContent == "Empty" ? content : categoryContent + content;
        await db.rawUpdate(
            'UPDATE categories SET content = ?  WHERE categoryName = ? ',
            [allContent, categoryName]).then((value) {
          notifyListeners();
          getData(db).then((value) {
            showSnackBar(context, title: "Added to $categoryName");
            make.toggleBottomSheet(context);
          });
        }).catchError((err) => err);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Warnning"),
                Divider(),
              ],
            ),
            content: const Text(
              'This title is Found, please change the value of it',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          ),
        );
      }
    } else {
      bool isFound = false;
      String comparedTitle = "";
      if (categoryContent != "Empty" &&
          categoryContent != "" &&
          categoryContent != null) {
        List valuesOfContent = fetchValues(content);
        List values = fetchValues(categoryContent);
        
        for (int i = 0; i < valuesOfContent.length; i++) {
          List<String> checkValues = valuesOfContent[i].split("\n");
          checkValues.removeLast();
          comparedTitle = checkValues[0].substring(3);
          if (content.contains(checkValues[0].substring(3))) {
           // print(comparedTitle);
            break;
          }
        }

        for (int i = 0; i < values.length; i++) {
          List<String> checkValues = values[i].split("\n");
          checkValues.removeLast();
          if (comparedTitle == checkValues[0].substring(3)) {
            isFound = true;
            //print(comparedTitle);
            break;
          }
        }
      }

      if (isFound == false) {
        String allContent =
            categoryContent == "Empty" ? content : categoryContent + content;
        await db.rawUpdate(
            'UPDATE categories SET content = ?  WHERE categoryName = ? ',
            [allContent, categoryName]).then((value) {
          notifyListeners();
          getData(db).then((value) {
            showSnackBar(context, title: "Added to $categoryName");
            make.toggleBottomSheet(context);
          });
        }).catchError((err) => err);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Warnning"),
                Divider(),
              ],
            ),
            content: const Text(
              'The first field is found, please change the value of it',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          ),
        );
      }
    }
  }

  Map categoryDetails = {};
  List categoryFields = [];
  String categoryContent = "";
  List<TextEditingController> fieldsController = [];
  void selectSpecificCategory({
    required String categoryName,
  }) {
    data
        .where((element) => element["categoryName"] == categoryName)
        .map((category) {
      categoryDetails = {
        "categoryName": category["categoryName"],
        "fields": category["fields"],
        "withImage": category["withImage"],
        "content": category["content"],
      };
      //notifyListeners();
    }).toList();

    categoryFields = categoryDetails["fields"]
        .toString()
        .trim()
        .substring(1, categoryDetails["fields"].toString().length - 1)
        .split(",")
        .toList();

    fieldsController = List.generate(
        categoryFields.length, (index) => TextEditingController());
    categoryContent = categoryDetails["content"];
    //notifyListeners();
  }

  String selectSpecificContent(
      {required String categoryName, required String title}) {
    selectSpecificCategory(categoryName: categoryName);
    if (categoryContent.contains(title)) {
      return categoryContent.substring(
        categoryContent.indexOf(title),
      );
    } else {
      return "not found";
    }
  }

  Future updateSpecificContent(
      {required Database db,
      required String newContent,
      required String categoryName,
      required String oldContent}) async {
    String allContent = categoryContent.replaceAll(oldContent, newContent);
    await db.rawUpdate(
        'UPDATE categories SET content = ?  WHERE categoryName = ? ',
        [allContent, categoryName]).then((value) {
      notifyListeners();
      getData(db).then((value) => "content of $categoryName is Updated");
      return null;
    }).catchError((error) => error);
  }

  Future addPhoto(
    BuildContext context, {
    required String categoryName,
    required String title,
  }) async {
    final read = context.read<MyProvider>();
    String spContent = selectSpecificContent(
      categoryName: categoryName,
      title: title,
    );
    int endIndex = spContent.indexOf("]");
    String oldContent = spContent.substring(0, endIndex);
    List images = fetchImages(spContent);
    read.files.removeWhere((element) => images.contains(element));
    ////print(images);

    //print("oldContent: $oldContent");
    if (read.files.isNotEmpty) {
      //print("read.files : ${read.files}");
      String updatedContent =
          oldContent.endsWith("File:") || oldContent.endsWith("[")
              ? read.files.toString().replaceAll("[", "")
              : "$oldContent, ${read.files.toString().replaceAll("[", "")}";
      await updateSpecificContent(
        newContent: updatedContent,
        oldContent: "$oldContent]",
        categoryName: categoryName,
        db: database,
      ).then((value) {
        getData(database);
      });
      notifyListeners();
    }
    notifyListeners();
  }

  Future deletePhoto(
    BuildContext context, {
    required String deletedPhoto,
    required String categoryName,
    required String title,
  }) async {
    String spContent = selectSpecificContent(
      categoryName: categoryName,
      title: title,
    ).trim();
    int endIndex = spContent.indexOf("]");
    String oldContent = "${spContent.substring(0, endIndex)}]";
    List images = fetchImages(oldContent);
    images.removeWhere((element) => element.toString().trim() == deletedPhoto);
    List updatedImages =
        images.map((image) => "File: ${image.toString().trim()}").toList();
    String updatedContent = "$title,$updatedImages";
    await updateSpecificContent(
      newContent: updatedContent,
      oldContent: oldContent,
      categoryName: categoryName,
      db: database,
    ).then((value) {
      getData(database);
    });
    notifyListeners();
  }

  Future updateWithOutPhotoContent(
      {required String newValue, required String categoryName}) async {
    var category =
        data.singleWhere((element) => categoryName == element["categoryName"]);
//print(category.first["content"]);
    String updatedContent = category["content"]
        .toString()
        .replaceAll(category["content"], newValue);
    //print("updatedContent:" + updatedContent);
    await database.rawUpdate(
        "UPDATE categories SET content = ? WHERE categoryName =? ",
        [updatedContent, categoryName]);
    notifyListeners();
  }

  Future editContentOfWithOutPhoto({
    required String categoryName,
    required String itemContent,
    required List<String> valueList,
    required List<String> labelList,
    List<TextEditingController>? newValue,
  }) async {
    String newContent = data.singleWhere(
        (category) => category["categoryName"] == categoryName)["content"];
    //print("bew:$newContent");
    //print(valueList);
    labelList = labelList.map((label) => label.trim()).toList();
    String title = labelList
            .toString()
            .replaceFirst("[", "(")
            .replaceFirst("]", ")")
            .trim() +
        valueList
            .toString()
            .replaceFirst("[", "(")
            .replaceFirst("]", ")")
            .trim();

    // print("it's ${newContent.contains(title)}");
    String newFav = itemContent;
    if (newValue != null) {
      for (int i = 0; i < valueList.length; i++) {
        newContent = newContent.replaceFirst(valueList[i], newValue[i].text);
        newFav = newFav.replaceFirst(valueList[i], newValue[i].text);
      }
    } else {
      newContent = newContent.replaceFirst(title, "");
      newFav = newFav.replaceFirst(title, "");
    }
//print("newFav : $newFav");
    await updateWithOutPhotoContent(
            categoryName: categoryName, newValue: newContent)
        .then((val) => getData(database).then((value) {}));

    List favContent = favList.map((favItem) => favItem["content"]).toList();
    // print(favContent);
    if (favContent.contains(itemContent)) {
      updateFavItem(newContent: newFav, oldContent: itemContent);
    }

    searchOn = {};
    notifyListeners();
  }

  Future editContentOfWithImage({
    required String categoryName,
    required String title,
    required List<String> valueList,
    required List<TextEditingController> controllers,
  }) async {
    String spContent =
        selectSpecificContent(categoryName: categoryName, title: title);
    int endIndex = spContent.indexOf("]");
    String oldContent = spContent.substring(0, endIndex);
    String newContent = oldContent;
    for (int i = 0; i < valueList.length; i++) {
      newContent = newContent.replaceFirst(valueList[i], controllers[i].text);
    }
    updateSpecificContent(
            db: database,
            newContent: "$newContent]",
            categoryName: categoryName,
            oldContent: "$oldContent]")
        .then((val) => getData(database).then((value) {}));
    List favContent = favList.map((favItem) => favItem["content"]).toList();
    if (favContent.contains("$oldContent]")) {
      updateFavItem(newContent: "$newContent]", oldContent: "$oldContent]");
    }
    searchOn = {};
    notifyListeners();
  }

// handling data that contains images
  List<String> fetchLabelsPhotos(String content) {
    List<String> labelList = content
        .replaceFirst("(", "")
        .substring(0, content.indexOf(')') - 1)
        .split(",")
        .toList();

    return labelList;
  }

  List<String> fetchValuesWithPhotos(String content) {
    List<String> values = content
        .substring(content.indexOf(')') + 2, content.lastIndexOf(")"))
        .split(",")
        .toList();

    return values;
  }

  List<String> fetchImages(String content) {
    List<String> images = content
        .substring(content.indexOf("[") + 1)
        .replaceAll("File: ", "")
        .replaceFirst("[", "")
        .replaceFirst("]", "")
        .trim()
        .split(",")
        .toList();
    return images;
  }

  Map<String, dynamic> fetchDataToDisplay(
      BuildContext context, String listContent) {
    //print(listContent);
    final watch = Provider.of<MyProvider>(context, listen: false);

    Map<String, dynamic> data = {};

    String title = listContent.substring(0, listContent.lastIndexOf(")") + 1);
    List<String> labelsList = fetchLabelsPhotos(listContent);
    List<String> valuesList = fetchValuesWithPhotos(listContent);
    List<String> imagesList = fetchImages(listContent);
    List urlsList = watch.fetchUrl(valuesList.toString());

    data = {
      "title": title,
      "labelsList": labelsList,
      "valuesList": valuesList,
      "imagesList": imagesList,
      "urlsList": urlsList
    };
    return data;
  }

//handling content withOut photos
  List<String> fetchLabels(String content) {
    if (content != "Empty") {
      String labels = content.substring(0, content.indexOf(")") + 1);
      return (labels.contains(',')
              ? labels.substring(1, labels.indexOf(")")).split(",")
              : [labels.substring(1, labels.indexOf(")"))])
          .toList();
    } else {
      return [];
    }
  }

  List<String> fetchValues(String content) {
    if (content != "Empty") {
      String labels = content.substring(0, content.indexOf(")") + 1);

      List labelList = fetchLabels(content);
      List handlingContent = content
          .replaceAll(labels, "")
          .replaceAll("(", "")
          .split(")")
          .map((data) => data.split(","))
          .toList();
      handlingContent.removeLast();
      List<String> displayContent = [];

      String merge = "";
      for (int i = 0; i < handlingContent.length; i++) {
        for (int j = 0; j < labelList.length; j++) {
          merge = "$merge${labelList[j].trim()} : ${handlingContent[i][j]}\n";
        }
      }

      displayContent = merge.split(labelList[0]);
      displayContent.removeAt(0);

      return displayContent;
    } else {
      return [];
    }
  }

  Map searchOn = {};
  void fetchSearchData() {
    List<String> categories = data
        .map((category) => category["categoryName"].toString().trim())
        .toList();
    String categoryName = "";
    categories.map((category) {
      selectSpecificCategory(categoryName: category);
      categoryName = category;
      if (categoryDetails["withImage"] == "true" &&
          categoryContent != "Empty") {
        List<String> content = categoryContent.toString().split("]").toList();
        for (int i = 0; i < content.length - 1; i++) {
          List valuesWithPhotos = fetchValuesWithPhotos(content[i]);
          final entire = <String, String>{
            "$categoryName:${valuesWithPhotos.first}": content[i]
          };
          searchOn.addEntries(entire.entries);
        }
      } else {
        //print("fromSearch:${categoryContent}content");
        if (categoryContent != "Empty" &&
            categoryContent != "" &&
            categoryContent != null) {
          List labelList = fetchLabels(categoryContent);
          List values = fetchValues(categoryContent);
          for (int i = 0; i < values.length; i++) {
            List<String> toEntire = values[i].split("\n");
            toEntire.removeLast();

            List itemContent = values[i].split("\n");
            itemContent[0] = labelList[0] + itemContent[0];
            itemContent.removeLast();

            //print("$categoryName:${toEntire[0].substring(3)}");
            final entire = <String, String>{
              "$categoryName:${toEntire[0].substring(3)}":
                  itemContent.toString()
            };
            searchOn.addEntries(entire.entries);
            // print("itemContent: $itemContent");
          }
        }
      }
    }).toList();
    socialMedia.map((savedItem) {
      final entire = <String, Map>{
        savedItem["platform"] + ":" + savedItem["title"]: savedItem
      };
      searchOn.addEntries(entire.entries);
    }).toList();

    notifyListeners();
    //print(searchOn.length);
  }
}
