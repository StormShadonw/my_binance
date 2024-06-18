class SymbolPrice {
  String? symbol;
  String? price;

  SymbolPrice({this.symbol, this.price});

  SymbolPrice.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['price'] = this.price;
    return data;
  }
}
