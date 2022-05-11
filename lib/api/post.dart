class Post {
  static const int numMoedas = 9;
  static const List<String> _currencies = [
    'USD',
    'EUR',
    'GBP',
    'ARS',
    'CAD',
    'AUD',
    'JPY',
    'CNY',
    'BTC'
  ];
  final Map<String, double> _currencyValue;

  Post(this._currencyValue);

  factory Post.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> jsonCurrencies = json['results']['currencies'];
    final Map<String, double> currencyValues = {};
    for (String currency in _currencies) {
      currencyValues[currency] = jsonCurrencies[currency]['buy'];
    }
    return Post(currencyValues);
  }

  Iterable<String> getCurrencies() {
    return _currencyValue.keys;
  }

  double getValueFromCurrency(String currency) {
    double? result = _currencyValue[currency];
    result ??= 0;
    return result;
  }
}
