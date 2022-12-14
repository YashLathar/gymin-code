import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gym_in/controllers/theme_controller.dart';
import 'package:gym_in/home_screen.dart';

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
import 'package:gym_in/pages/user_page.dart';
import 'package:gym_in/pages/video_page_info.dart';
import 'package:gym_in/pages/video_page_selection.dart';
import 'package:gym_in/pages/wallet_page.dart';
import 'package:gym_in/themes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late FirebaseAnalytics analytics;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_live_51K7hIISAFFJ3hJGuUeKxb1G4yOxzTDfhjVSmua93xU1CJJC0iOz16zexjp8QmZsRtFElVDPn6j9mUqRc4lpgIKJg00RYNBiWoY';
  await Firebase.initializeApp();
  analytics = FirebaseAnalytics();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider).theme;

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

          // case "/timeSelectorPage":
          //   return MaterialPageRoute(builder: (_) => TimeSelector());

          case "/feedsPage":
            return MaterialPageRoute(builder: (_) => FeedsPage());

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
