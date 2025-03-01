part of 'home_bloc.dart';

class HomeState {
  final Status status;
  final Map<String, String> title = {
    'en': "Currency",
    'ru': "Валюта",
    'uz': "Valyuta",
    'uzc': "Валюта",
  };
  final Map<String, String> btnCalculateText = {
    'en': 'Calculate',
    'ru': 'Рассчитать',
    'uz': 'Hisoblash',
    'uzc': 'Ҳисоблаш',
  };

  final String currentLang;
  final int expandedItemIndex;
  final String? errorMessage;
  final List<CurrencyData> currencyList;
  final SideEffect sideEffect;

  HomeState({
    this.currencyList = const [],
    this.status = Status.loading,
    this.errorMessage = '',
    this.expandedItemIndex = -1,
    this.sideEffect = SideEffect.nothing,
    this.currentLang = 'ru',
  });

  HomeState copy({
    Status? status,
    List<CurrencyData>? currencyList,
    String? errorMessage,
    int? expandedItemIndex,
    String? currentLang,
    SideEffect? sideEffect,
  }) => HomeState(
    status: status ?? this.status,
    currencyList: currencyList ?? this.currencyList,
    errorMessage: errorMessage ?? this.errorMessage,
    expandedItemIndex: expandedItemIndex ?? this.expandedItemIndex,
    currentLang: currentLang ?? this.currentLang,
    sideEffect: sideEffect ?? this.sideEffect,
  );
}

enum Status { loading, success, error }

enum SideEffect {
  nothing,
  openCalculateSheet,
  openCalendarDialog,
  openLanguageDialog,
}
