class CurrencyData {
  final int id;
  final String code;
  final String ccy;
  final Map<String, String> names;
  final String nominal;
  final String rate;
  final String diff;
  final String date;

  CurrencyData({
    required this.id,
    required this.code,
    required this.ccy,
    required this.names,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
  });

  @override
  String toString() {
    return 'CurrencyData(id: $id, code: $code, ccy: $ccy, names: $names, '
        'nominal: $nominal, rate: $rate, diff: $diff, date: $date)';
  }

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      id: json['id'] ?? 0,
      code: json['Code'] ?? '',
      ccy: json['Ccy'] ?? '',
      names: {
        'ru': json['CcyNm_RU'] ?? '',
        'uz': json['CcyNm_UZ'] ?? '',
        'uzc': json['CcyNm_UZC'] ?? '',
        'en': json['CcyNm_EN'] ?? '',
      },
      nominal: json['Nominal'] ?? '',
      rate: json['Rate'] ?? '',
      diff: json['Diff'] ?? '',
      date: json['Date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Code': code,
      'Ccy': ccy,
      'CcyNm_RU': names['ru'],
      'CcyNm_UZ': names['uz'],
      'CcyNm_UZC': names['uzc'],
      'CcyNm_EN': names['en'],
      'Nominal': nominal,
      'Rate': rate,
      'Diff': diff,
      'Date': date,
    };
  }
}