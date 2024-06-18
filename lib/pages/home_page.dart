import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_binance/helpers/alerts.dart';
import 'package:my_binance/helpers/formats.dart';
import 'package:my_binance/models/symbol_24hr_price.dart';
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
  List<Symbol24Price> symbols24Price = [];
  var colors = [
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];

  Future<void> getInitData() async {
    setState(() {
      _isLoading = true;
    });
    print("klk 2");
    await dataProvider.getSymbols24hrPrice();
    var result = await dataProvider.getSymbolsPrice();
    if (result != null) {
      showError(context, result);
    } else {
      symbolsPrice = dataProvider.symbolsPrice;
      symbols24Price = dataProvider.symbols24hrPrice;
      colors.shuffle();
      symbolsPrice.removeWhere(
        (element) => !element.symbol!.contains("USDT", 3),
      );
      symbols24Price.removeWhere(
        (element) => !element.symbol!.contains("USDT", 3),
      );
      symbols24Price.sort(
        (a, b) => (double.parse(b.volume ?? "0.00") -
                double.parse(a.volume ?? "0.00"))
            .toInt(),
      );
      symbolsPrice.sort(
        (a, b) =>
            (double.parse(b.price ?? "0.00") - double.parse(a.price ?? "0.00"))
                .toInt(),
      );
      symbolsPrice = symbolsPrice.getRange(0, 5).toList();
      symbols24Price = symbols24Price.getRange(0, 5).toList();
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

  Widget subTitle(Size size, String content) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      width: size.width,
      child: Text(
        content,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
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
                // vertical: 10,
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  subTitle(size, "5 Monedas por precio"),
                  Container(
                    width: size.width,
                    height: 200,
                    child: Builder(builder: (context) {
                      return PieChart(PieChartData(
                        sections: List.generate(
                          symbolsPrice.length,
                          (index) => PieChartSectionData(
                            titleStyle: Theme.of(context).textTheme.bodySmall,
                            value: double.parse(
                                symbolsPrice[index].price ?? "0.00"),
                            title:
                                "${symbolsPrice[index].symbol}: ${MyFormats().currencyFormat(double.parse(symbolsPrice[index].price ?? "0.00"))}",
                            showTitle: true,
                            radius: 70,
                            color: colors[index],
                          ),
                        ),
                      ));
                    }),
                  ),
                  subTitle(size, "5 Monedas por volumen"),
                  Container(
                    width: size.width,
                    height: 250,
                    child: Builder(builder: (context) {
                      return BarChart(
                        BarChartData(
                          maxY:
                              double.parse(symbols24Price[0].volume ?? "0.00") *
                                  1.10,
                          titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) => SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                symbols24Price[value.toInt()].symbol ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 7,
                                    ),
                              ),
                            ),
                          ))),
                          barGroups: List.generate(
                            symbols24Price.length,
                            (index) => BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: double.parse(
                                      symbols24Price[index].volume ?? "0.00"),
                                  color: colors[index],
                                )
                              ],
                              // value: double.parse(
                              //     symbols24Price[index].volume ?? "0.00"),
                              // title:
                              //     "${symbols24Price[index].symbol}: ${MyFormats().currencyFormat(double.parse(symbols24Price[index].volume ?? "0.00"))}",
                              // showTitle: true,
                              // radius: 70,
                              // color: colors[index],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              )),
            )),
    );
  }
}
