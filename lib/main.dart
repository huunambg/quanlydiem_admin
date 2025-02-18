import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem_admin/screen/splash/splash.dart';
import 'dependecy_injection.dart' as dependecy_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependecy_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
