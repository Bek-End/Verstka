import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testVerstka/screens/result_of_search_screen.dart';
import 'package:testVerstka/screens/search_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.light, fontFamily: "SFProDisplay"),
      home: SearchScreen(),
      routes: {
        SearchScreen.routeName: (context) => SearchScreen(),
        ResultOfSearch.routeName: (context) => ResultOfSearch()
      },
    );
  }
}
