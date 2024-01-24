import 'package:chat_app/core/init/navigation/navigation_routes.dart';
import 'package:chat_app/core/init/navigation/navigation_service.dart';
import 'package:chat_app/features/signin/provider/signin_provider.dart';
import 'package:chat_app/features/splash/provider/splash_provider.dart';

import 'package:chat_app/features/splash/view/splash_view.dart';
import 'package:chat_app/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<SplashProvider>(create: (context) => SplashProvider()),
    ChangeNotifierProvider<SignInProvider>(create: (context) => SignInProvider()),
    ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashView(),
    );
  }
}

/* AIzaSyCWLFKXvnC_96qOnokrW0E1E45nOqrSGRc */
