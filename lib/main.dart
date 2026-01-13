import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import 'package:save/model/cash_helper.dart';
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

  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<CashHelper>(
              create: (_) {
                return CashHelper()..loadPref();
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
          ],
          child: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CashHelper>(builder: (context, value, child) {
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
          DisplaySocialMedia.routeName: (context) => const DisplaySocialMedia(),
          PlatformData.routeName: (context) => const PlatformData(),
        },
      );
    });
  }
}
