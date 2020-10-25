import 'package:baby_milk/pages/homePage/index.dart';
import 'package:baby_milk/store/global_store.dart';
import 'package:baby_milk/store/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    ChangeNotifierProvider<GrobalStoreProvider>(
      create: (_) => GrobalStoreProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '宝宝计划',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
          child: HomePage(title: '吃奶时光'),
        ));
  }
}
