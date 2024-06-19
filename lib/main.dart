import 'package:flutter/material.dart';
import 'package:my_binance/pages/auth_dage.dart';
import 'package:my_binance/pages/home_page.dart';
import 'package:my_binance/providers/data_provider.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider.value(value: DataProvider()),
      ],
      child: MaterialApp(
        title: 'My Binance Api App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
          useMaterial3: true,
        ),
        home: const AuthPage(),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          AuthPage.routeName: (context) => const AuthPage(),
        },
      ),
    );
  }
}
