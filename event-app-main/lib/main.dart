import 'package:event_app/services/payment_service.dart';
import 'package:event_app/view/ui/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PaymentServices.init();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "What's the move",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: GoogleFonts.adamina().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xffddbd69),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          primaryColorDark: Color(0xff785d2e)),
      home: SplashView(),
    );
  }
}
