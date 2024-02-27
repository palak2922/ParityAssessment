import 'package:flutter/material.dart';
import 'package:parityassessment/Services/FeaturedModelView.dart';
import 'package:parityassessment/Services/PopularModelView.dart';
import 'package:provider/provider.dart';
import 'Screens/HomePage.dart';
import 'Services/TopModeView.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DealViewModel()),
        ChangeNotifierProvider(create: (_) => PopularViewModel()),
        ChangeNotifierProvider(create: (_) => FeaturedViewModel()),
      ],
      child: MaterialApp(
        title: 'Parity Assessment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}


