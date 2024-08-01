import 'package:flutter/material.dart';
import 'package:photo_editor_app/data/di/injection.dart';

import 'package:photo_editor_app/notifier/image_notifier.dart';
import 'package:photo_editor_app/pages/home_page/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injection.register();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Editor App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
