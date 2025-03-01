import '../model/currency_data.dart';
import '../source/remote/response/currency_response.dart';

extension CurrencyResponseMapper on CurrencyResponse {
  CurrencyData toCurrencyData() {
    return CurrencyData(
      id: id ?? 0,
      code: code ?? '',
      ccy: ccy ?? '',
      names: {
        'ru': ccyNmRU ?? '',
        'uz': ccyNmUZ ?? '',
        'uzc': ccyNmUZC ?? '',
        'en': ccyNmEN ?? '',
      },
      nominal: nominal ?? '',
      rate: rate ?? '',
      diff: (diff != null && diff!.isNotEmpty) ? diff! : '0.00',
      date: date ?? '',
    );
  }
}
