class TradingDay {
  String? symbol;
  String? priceChange;
  String? priceChangePercent;
  String? weightedAvgPrice;
  String? openPrice;
  String? highPrice;
  String? lowPrice;
  String? lastPrice;
  String? volume;
  String? quoteVolume;
  int? openTime;
  int? closeTime;
  int? firstId;
  int? lastId;
  int? count;

  TradingDay(
      {this.symbol,
      this.priceChange,
      this.priceChangePercent,
      this.weightedAvgPrice,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.lastPrice,
      this.volume,
      this.quoteVolume,
      this.openTime,
      this.closeTime,
      this.firstId,
      this.lastId,
      this.count});

  TradingDay.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    priceChange = json['priceChange'];
    priceChangePercent = json['priceChangePercent'];
    weightedAvgPrice = json['weightedAvgPrice'];
    openPrice = json['openPrice'];
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    lastPrice = json['lastPrice'];
    volume = json['volume'];
    quoteVolume = json['quoteVolume'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    firstId = json['firstId'];
    lastId = json['lastId'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['priceChange'] = this.priceChange;
    data['priceChangePercent'] = this.priceChangePercent;
    data['weightedAvgPrice'] = this.weightedAvgPrice;
    data['openPrice'] = this.openPrice;
    data['highPrice'] = this.highPrice;
    data['lowPrice'] = this.lowPrice;
    data['lastPrice'] = this.lastPrice;
    data['volume'] = this.volume;
    data['quoteVolume'] = this.quoteVolume;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['firstId'] = this.firstId;
    data['lastId'] = this.lastId;
    data['count'] = this.count;
    return data;
  }
}
