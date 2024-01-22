import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/firebase_options.dart';
import 'package:instagram_clone_flutter/root.dart';

import 'app.dart';
import 'binding/init_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: Colors.white,
      //   titleTextStyle: TextStyle(color: Colors.black),
      // )
      ),
      home: RootPage(),
      initialBinding: InitBinding(),
    );
  }
}
