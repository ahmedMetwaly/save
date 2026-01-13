// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:async';
//import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../model/shared_data.dart';
import '../view/widgets/bottom_sheet/bottom_sheet.dart';
import '../view/widgets/components/gallary_view.dart';

class MyProvider with ChangeNotifier {
  //BottomSheet
  bool isBottomSheetOpened = false;
  IconData fabIcon = Icons.add;
  String fabTitle = "Add subject";
  // ignore: prefer_typing_uninitialized_variables
  var dropDownButtonItem;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isConnected = false;

 /*  bool _getUrlValid(String url) {
    bool isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
      hostWhitelist: ['https://youtube.com/','https://facebook.com/'],
      //hostBlacklist: ['https://facebook.com/'],
    );
    return isUrlValid;
  }
  bool imageFound = false;
  void getMetadata(String url) async {
    try {
      bool isValid = _getUrlValid(url);
      if (isValid) {
       var metadata=  await AnyLinkPreview.getMetadata(
          link: url,
          cache: const Duration(days: 7),
          proxyUrl:
              "https://cors-anywhere.herokuapp.com/", // Needed for web app
        );
        //debugPrint(metadata?.title);
        //debugPrint(metadata?.desc);
       // print(metadata?.image);
        //metadata?.image != null ? imageFound = true : imageFound=false;
        notifyListeners();
      } else {
        //debugPrint("URL is not valid");
      }
    } catch (error) {
      error;
    }
  }
 */
  Future<void> checkConnection() async {
    isConnected = await InternetConnectionChecker.instance.hasConnection;
    //print("isConnected: $isConnected");
    notifyListeners();
  }


  Future<void> execute() async {
     isConnected = await InternetConnectionChecker.instance.hasConnection;
   
    // actively listen for status updates
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker.instance.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            isConnected = true;
            // print('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            isConnected = false;
            //print('You are disconnected from the internet.');
            break;
          case InternetConnectionStatus.slow:
            // ignore: avoid_print
            isConnected = false;
            //print('You are disconnected from the internet.');
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    //await Future<void>.delayed(const Duration(seconds: 30));
    //await listener.cancel();

    notifyListeners();
  }

  void toggleBottomSheet(context) {
    if (isBottomSheetOpened) {
      isBottomSheetOpened = false;
      dropDownButtonItem = null;
      fabIcon = Icons.add;
      fabTitle = "Add subject";
      files = [];
      encodedImages = [];
      Navigator.of(context).pop();
    } else {
      isBottomSheetOpened = true;
      fabIcon = Icons.save_as_rounded;
      fabTitle = "Save subject";
      Scaffold.of(context)
          .showBottomSheet(
            (context) => Form(key: formKey, child: const ShowBottomSheet()),
          )
          .closed
          .then((value) {
        dropDownButtonItem = null;
        fabIcon = Icons.add;
        fabTitle = "Add subject";
        isBottomSheetOpened = false;
        files = [];
        encodedImages = [];
        notifyListeners();
      });
    }
    notifyListeners();
  }

  // DropButton
  void changeDropButtomItem(value) {
    dropDownButtonItem = value;
    notifyListeners();
  }

  //DropButtonContent

  bool containsImage = false;
  void changeSwitch(value) {
    containsImage = value;
    notifyListeners();
  }

  // create fields
  var controllerNumbers = 1;
  List<TextEditingController> controllers = [
    TextEditingController(),
  ];
  List<String> fieldsName = [];
  void changeControllerNumbers({required String operation}) {
    if (operation == "add" && controllerNumbers < 10) {
      controllerNumbers++;
      controllers.add(TextEditingController());
      notifyListeners();
    } else if (operation == "minus" && controllerNumbers > 1) {
      controllerNumbers--;
      controllers.removeLast();
      notifyListeners();
    }
  }

  void extractTextFromControllers(List<TextEditingController> controllers) {
    controllers.map((field) {
      fieldsName.add(field.text);
      notifyListeners();
    }).toList();
  }

  void restInputs() {
    controllerNumbers = 1;
    controllers = [TextEditingController()];
    fieldsName = [];
    containsImage = false;
    notifyListeners();
  }

//images
  final ImagePicker picker = ImagePicker();
  List<File?> files = [];
  List<String> encodedImages = [];

  Future selectImages() async {
    List<XFile?> selectedImages = await picker.pickMultiImage();

    //print("selectedImages: $selectedImages");
    if (selectedImages.isNotEmpty) {
      files = List.generate(
        selectedImages.length,
        (index) {
          return File(selectedImages[index]!.path);
        },
      );
      notifyListeners();
    }
    notifyListeners();
  }

  void removeImage(index) {
    files.removeAt(index);
    /* print("F : ${files.length}");
    print("en : ${encodedImages.length}"); */
    notifyListeners();
  }

  void openPhoto(BuildContext context,
      {required final int index,
      required List<String> galleryItems,
      required String categoryName,
      required title}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallaryView(
          categoryName: categoryName,
          title: title,
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
        ),
      ),
    );
  }

  List fetchUrl(text) {
    final urlRegExp = RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    final urlMatches = urlRegExp.allMatches(text);
    List urls = urlMatches
        .map((urlMatch) => text.substring(urlMatch.start, urlMatch.end))
        .toList();
    return urls;
  }

  String sharedData = "";
  getDataFromOtherApps() async {
    try {
      await DataClass().sharedData().then((value) {
        sharedData = fetchUrl(value)[0];
        //print("sharedData : $sharedData");
        notifyListeners();
      });
    } catch (error) {
      //print(error);
      error;
    }
  }

// socialMedia
}
