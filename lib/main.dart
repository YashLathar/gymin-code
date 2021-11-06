import 'package:flutter/material.dart';
import 'package:gym_in/home_screen.dart';
import 'package:gym_in/pages/activity_page.dart';
import 'package:gym_in/pages/booking_result.dart';
import 'package:gym_in/pages/chat_page.dart';
import 'package:gym_in/pages/feeds_page.dart';
import 'package:gym_in/pages/gymlist_page.dart';
import 'package:gym_in/pages/product_cart_page.dart';
import 'package:gym_in/pages/products_page.dart';
import 'package:gym_in/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:gym_in/pages/signup_page.dart';
import 'package:gym_in/pages/favorites_page.dart';
import 'package:gym_in/pages/time_selector_page.dart';
import 'package:gym_in/pages/user_page.dart';
import 'package:gym_in/pages/video_page_info.dart';
import 'package:gym_in/pages/video_page_selection.dart';
import 'package:gym_in/pages/wallet_page.dart';
import 'package:gym_in/themes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymIn',
      debugShowCheckedModeBanner: false,
      // theme: Styles.themeData(context),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case "/homePage":
            return MaterialPageRoute(builder: (_) => HomePage());

          case "/videosPage":
            return MaterialPageRoute(builder: (_) => VideoScreen());

          case "/chatPage":
            return MaterialPageRoute(builder: (_) => ChatPage());

          case "/signUpPage":
            return MaterialPageRoute(builder: (_) => SignupPage());
          case "/settingPage":
            return MaterialPageRoute(builder: (_) => SettingPage());

          case "/productCartPage":
            return MaterialPageRoute(builder: (_) => ProductCartPage());

          case "/signInPage":
            return MaterialPageRoute(builder: (_) => LoginPage());
          case "/walletPage":
            return MaterialPageRoute(builder: (_) => WalletPage());

          case "/userpage":
            return MaterialPageRoute(builder: (_) => UserPage());

          case "/timeSelectorPage":
            return MaterialPageRoute(builder: (_) => TimeSelector());

          case "/feedsPage":
            return MaterialPageRoute(builder: (_) => FeedsPage());

          case "/activityPage":
            return MaterialPageRoute(builder: (_) => ActivityPage());

          case "/favorites":
            return MaterialPageRoute(builder: (_) => FavoritesPage());

          case "/productsPage":
            return MaterialPageRoute(builder: (_) => GymProductsPage());

          case "/QrResult":
            return MaterialPageRoute(
                builder: (_) => QrResultScreen(
                      dataIndex: args,
                    ));

          case "/gymListPage":
            return MaterialPageRoute(
              builder: (_) => GymListPage(),
            );

          case "/videoInfoPage":
            return MaterialPageRoute(
              builder: (_) => VideoInfoPage(
                dataIndex: args,
              ),
            );
        }
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('ERROR'),
            ),
          );
        });
      },
    );
  }
}
