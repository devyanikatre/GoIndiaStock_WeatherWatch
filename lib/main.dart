import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'screens/home.dart';

void main() async {
  runApp(const ProviderScope(child: MainApp()));
  await dotenv.load(fileName: ".env");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          home: Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    ));
  }
}
