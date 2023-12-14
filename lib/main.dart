import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/cach_helper.dart';
import 'package:save/view/screens/add_category.dart';
import 'package:save/view/screens/social_media/display_social_media.dart';
import 'package:save/view/screens/fav.dart';
import 'package:save/view/screens/social_media/platform_data.dart';
import 'package:save/view/screens/search.dart';
import 'package:save/view/screens/social_media/save_to_social_media.dart';
import 'package:save/view/screens/splash_screen.dart';
import 'model/database.dart';
import 'view/screens/home.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));


  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<CachHelper>(
        create: (_) {
          return CachHelper()..loadPref();
        },
      ),
      ChangeNotifierProvider<MySql>(
        create: (_) {
          return MySql()..openDataBase();
        },
      ),
      ChangeNotifierProvider<MyProvider>(
        create: (context) {
          return MyProvider()..getDataFromOtherApps();
        },
      ),
    ], child: const MainScreen()),
  );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CachHelper>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value.lightTheme,
          darkTheme: value.darkTheme,
          themeMode: value.isDark == true ? ThemeMode.dark : ThemeMode.light,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            Home.routeName: (context) => const Home(),
            AddCategory.routeName: (context) => const AddCategory(),
            SearchScreen.routeName: (context) => const SearchScreen(),
            FavScreen.routeName: (context) => const FavScreen(),
            SaveToSocialMedia.routeName: (context) => const SaveToSocialMedia(),
            DisplaySocialMedia.routeName: (context) =>
                const DisplaySocialMedia(),
            PlatformData.routeName: (context) => const PlatformData(),
          },
        );
      },
    );
  }
}
