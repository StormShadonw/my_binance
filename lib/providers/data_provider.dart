import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_binance/models/symbol_price.dart';

class DataProvider extends ChangeNotifier {
  List<SymbolPrice> symbolsPrice = [];

  Future<String?> getSymbolsPrice() async {
    try {
      debugPrint("klk");
      final dio = Dio();
      final response = await dio.get(
        'https://api.binance.com/api/v3/ticker/price',
      );
      debugPrint(response.data.toString());
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    }
  }
}
