import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_binance/models/symbol_24hr_price.dart';
import 'package:my_binance/models/symbol_price.dart';
import 'package:my_binance/models/trading_day.dart';
import 'package:my_binance/models/user.dart';

class DataProvider extends ChangeNotifier {
  List<SymbolPrice> symbolsPrice = [];
  List<Symbol24Price> symbols24hrPrice = [];
  List<TradingDay> tradingDay = [];
  User? user = null;
  List<User> users = [];
  BaseOptions baseOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  List<User> getUsers() {
    return users;
  }

  User? getUser(String email, String password) {
    return users
        .where(
          (element) => element.email == email && element.password == password,
        )
        .first;
  }

  String? login(String email, String password) {
    var _users = users.where(
      (element) => element.email == email && element.password == password,
    );
    if (_users.isEmpty) {
      return "Usuario no encontrado, favor intentar con otra contraseña u otro correo";
    }
    User? _user = _users.first;
    if (_user != null) {
      user = _user;
      notifyListeners();
      return null;
    } else {
      return "Usuario no encontrado, favor intentar con otra contraseña u otro correo";
    }
  }

  String? insertNewUser(String email, String password) {
    if (users.indexWhere(
          (element) => element.email == email,
        ) >=
        0) {
      return "Este correo ya esta registrado, debe de registrarse con otro correo";
    }
    users.add(User(email: email, password: password));
    return null;
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  Future<String?> getSymbolsPrice() async {
    try {
      symbolsPrice.clear();
      final dio = Dio(baseOptions);
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
      final dio = Dio(baseOptions);
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

  Future<String?> getTradingDay() async {
    try {
      tradingDay.clear();
      final dio = Dio(baseOptions);
      final response = await dio.get(
        'https://api.binance.com/api/v3/ticker/24hr',
        queryParameters: {
          "symbols": '["BTCUSDT","ETHUSDT","BNBUSDT","SOLUSDT","XRPUSDT"]',
        },
      );
      debugPrint(response.data.toString());
      if (response.data != null) {
        for (var element in response.data) {
          tradingDay.add(TradingDay.fromJson(element));
        }
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    }
  }
}
