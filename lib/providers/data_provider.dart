import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_binance/models/symbol_price.dart';

class DataProvider extends ChangeNotifier {
  List<SymbolPrice> symbolsPrice = [];

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
}
