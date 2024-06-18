import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_binance/models/symbol_24hr_price.dart';
import 'package:my_binance/models/symbol_price.dart';

class DataProvider extends ChangeNotifier {
  List<SymbolPrice> symbolsPrice = [];
  List<Symbol24Price> symbols24hrPrice = [];

  Future<String?> getSymbolsPrice() async {
    try {
      symbolsPrice.clear();
      final dio = Dio();
      final response = await dio.get(
        'https://api.binance.com/api/v3/ticker/price',
      );
      debugPrint(response.data.toString());
      if (response.data != null) {
        for (var element in response.data) {
          symbolsPrice.add(SymbolPrice.fromJson(element));
        }
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    }
  }

  Future<String?> getSymbols24hrPrice() async {
    try {
      symbols24hrPrice.clear();
      final dio = Dio();
      final response = await dio.get(
        'https://api.binance.com/api/v3/ticker/24hr',
        // queryParameters: {
        //   "symbol": "BTCUSDT",
        // },
      );
      debugPrint(response.data.toString());
      if (response.data != null) {
        for (var element in response.data) {
          symbols24hrPrice.add(Symbol24Price.fromJson(element));
        }
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    }
  }
}
