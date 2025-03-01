import 'package:currency_app_sultonbek/data/mapper/AppMapper.dart';
import 'package:currency_app_sultonbek/data/model/currency_data.dart';
import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import '../response/currency_response.dart';

class CurrencyService {
  final talker = Talker();

  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://cbu.uz/uz/',
      receiveDataWhenStatusError: true,
      receiveTimeout: Duration(seconds: 25),
      connectTimeout: Duration(seconds: 25),
      sendTimeout: Duration(seconds: 25),
    ),
  );

  Future<List<CurrencyData>?> getAllForToday() async {
    try {
      final response = await _dio.get('arkhiv-kursov-valyut/json/');
      final list =
          (response.data as List)
              .map((element) => CurrencyResponse.fromJson(element))
              .toList();
      talker.info(list);

      return list.map((currencyResponse) {
        return currencyResponse.toCurrencyData();
      }).toList();
    } catch (e, st) {
      talker.handle(e, st);
    }
  }

  Future<List<CurrencyData>?> getAllByDate(String date) async {
    try {
      final response = await _dio.get('arkhiv-kursov-valyut/json/all/$date/');
      final list =
          (response.data as List)
              .map((element) => CurrencyResponse.fromJson(element))
              .toList();
      talker.info(list);

      return list.map((currencyResponse) {
        return currencyResponse.toCurrencyData();
      }).toList();
    } catch (e, st) {
      talker.handle(e, st);
    }
  }
}
