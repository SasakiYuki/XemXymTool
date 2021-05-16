class LastPrice {
  final double lastPrice;

  LastPrice({this.lastPrice});

  factory LastPrice.fromJson(Map<String, dynamic> json) {
    return LastPrice(lastPrice: json['last_price']);
  }
}
