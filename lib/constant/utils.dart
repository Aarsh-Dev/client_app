String convertAnyToAny(
    Map exchangeRates, String amount, String fromCurrency, String toCurrency) {
  var doubleVal = double.tryParse(amount);
  if (doubleVal == null) return "";
  String output =
  (doubleVal / exchangeRates[fromCurrency] * exchangeRates[toCurrency])
      .toStringAsFixed(5);
  return output;
}