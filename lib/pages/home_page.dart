import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_binance/helpers/alerts.dart';
import 'package:my_binance/models/symbol_price.dart';
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
  List<SymbolPrice> symbolsPrice = [];

  Future<void> getInitData() async {
    setState(() {
      _isLoading = true;
    });
    print("klk 2");
    var result = await dataProvider.getSymbolsPrice();
    if (result != null) {
      showError(context, result);
    } else {
      setState(() {
        symbolsPrice = dataProvider.symbolsPrice;
      });
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SafeArea(
              child: Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    width: size.width,
                    child: Text(
                      "Monedas mas altas",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 200,
                    child: Builder(builder: (context) {
                      var colors = [
                        Colors.redAccent,
                        Colors.yellowAccent,
                        Colors.blueAccent,
                        Colors.greenAccent,
                        Colors.purpleAccent,
                      ];
                      colors.shuffle();
                      symbolsPrice.sort(
                        (a, b) => (double.parse(b.price ?? "0.00") -
                                double.parse(a.price ?? "0.00"))
                            .toInt(),
                      );
                      var symbols = symbolsPrice.getRange(0, 5).toList();
                      return PieChart(PieChartData(
                        pieTouchData: PieTouchData(
                          enabled: true,
                        ),
                        sections: List.generate(
                          symbols.length,
                          (index) => PieChartSectionData(
                            value: double.parse(symbols[index].price ?? "0.00"),
                            title: symbols[index].symbol,
                            showTitle: true,
                            radius: 70,
                            color: colors[index],
                          ),
                        ),
                      ));
                    }),
                  )
                ],
              )),
            )),
    );
  }
}
