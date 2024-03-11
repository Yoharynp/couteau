import 'package:couteau/Screens/Inicio/menu_provider.dart';
import 'package:couteau/Screens/Inicio/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(create: (context) => MenuIndexProvider(), child: const MyApp())
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Couteau',
      home: ScreenHomeScreen(),
      );
  }
}