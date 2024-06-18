import 'package:flutter/material.dart';
import 'package:my_binance/helpers/alerts.dart';
import 'package:my_binance/providers/data_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  DataProvider dataProvider = DataProvider();

  Future<void> getInitData() async {
    setState(() {
      _isLoading = true;
    });
    debugPrint("klk 2");
    var result = await dataProvider.getSymbolsPrice();
    if (result != null) {
      showError(context, result);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );
    getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Center(
              child: Text("HomePage"),
            ),
    );
  }
}
