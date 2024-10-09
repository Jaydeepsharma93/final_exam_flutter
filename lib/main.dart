import 'package:final_exam_flutter/views/homescreen.dart';
import 'package:final_exam_flutter/views/likenotes.dart';
import 'package:final_exam_flutter/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/", page:() =>  SplashScreen()),
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/like", page: () => LikedNotesPage())
      ],
     );
  }
}
