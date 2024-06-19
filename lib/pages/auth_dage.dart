import 'package:flutter/material.dart';
import 'package:my_binance/widgets/login.dart';
import 'package:my_binance/widgets/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const String routeName = "/AuthPage";

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                style: BorderStyle.solid,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 1,
                )
              ]),
          width: size.width * 0.85,
          height: size.height * 0.65,
          child: const DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: TabBar(tabs: [
                  Tab(
                    text: "Iniciar Sesion",
                    icon: Icon(Icons.login),
                  ),
                  Tab(
                    text: "Registrarse",
                    icon: Icon(Icons.people),
                  ),
                ]),
                body: TabBarView(
                  children: [
                    LoginPage(),
                    RegisterPage(),
                  ],
                ),
              )),
        ),
      )),
    );
  }
}
