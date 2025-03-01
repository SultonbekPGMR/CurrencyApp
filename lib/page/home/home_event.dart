part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetCurrency extends HomeEvent {}

class OnItemExpandClick extends HomeEvent {
  final int index;

  OnItemExpandClick(this.index);
}

class OnItemCollapseClick extends HomeEvent {
  final int index;

  OnItemCollapseClick(this.index);
}

class OnCalculateClick extends HomeEvent {}

class OnChangeLangClick extends HomeEvent {}

class OnLangChanged extends HomeEvent {
  final String newLang;

  OnLangChanged(this.newLang);
}

class OnCalendarClick extends HomeEvent {}

class GetCurrencyForSelectedDate extends HomeEvent {
  final String selectedData;

  GetCurrencyForSelectedDate(this.selectedData);
}

class OnSideEffectConsumed extends HomeEvent {}
