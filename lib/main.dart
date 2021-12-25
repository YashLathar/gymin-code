import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gym_in/controllers/theme_controller.dart';
import 'package:gym_in/home_screen.dart';
import 'package:gym_in/pages/activity_page.dart';
import 'package:gym_in/pages/chat_page.dart';
import 'package:gym_in/pages/feeds_page.dart';
import 'package:gym_in/pages/orders_page.dart';
import 'package:gym_in/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/pages/product_cart_page.dart';
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

late FirebaseAnalytics analytics;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51K7hIISAFFJ3hJGuB2QOQg6iAdnbjHJ1HZvHvoEMTDY0N03Dqa8i5MnWXv2PA0nwzMg5WAei8839LYsnzsw5ZKWh00tdIjWw0E';
  await Firebase.initializeApp();
  analytics = FirebaseAnalytics();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeControllerProvider).theme;

    return MaterialApp(
      title: 'GymIn',
      debugShowCheckedModeBanner: false,
      theme: theme ? AppTheme.darkTheme : AppTheme.lightTheme,
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

          // case "/productsPage":
          //   return MaterialPageRoute(builder: (_) => GymProductsPage());

          case "/ordersPage":
            return MaterialPageRoute(builder: (_) => OrdersPage());

          // case "/gymListPage":
          //   return MaterialPageRoute(
          //     builder: (_) => GymListPage(),
          //   );

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
