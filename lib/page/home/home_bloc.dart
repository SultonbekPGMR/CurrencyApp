import 'package:bloc/bloc.dart';
import 'package:currency_app_sultonbek/data/model/currency_data.dart';
import 'package:currency_app_sultonbek/data/source/remote/service/currency_service.dart';
import 'package:talker/talker.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final talker = Talker();
  final currencyService = CurrencyService();

  HomeBloc() : super(HomeState()) {
    on<GetCurrency>((event, emit) async {
      emit(state.copy(status: Status.loading));
      emit(
        state.copy(
          status: Status.success,
          currencyList: await currencyService.getAllForToday() ?? [],
        ),
      );
    });
    on<GetCurrencyForSelectedDate>((event, emit) async {
      emit(state.copy(status: Status.loading));
      emit(
        state.copy(
          status: Status.success,
          currencyList:
              await currencyService.getAllByDate(event.selectedData) ?? [],
        ),
      );
    });

    on<OnItemExpandClick>((event, emit) async {
      emit(state.copy(expandedItemIndex: event.index));
    });

    on<OnItemCollapseClick>((event, emit) async {
      emit(state.copy(expandedItemIndex: -1));
    });

    on<OnCalculateClick>((event, emit) async {
      emit(state.copy(sideEffect: SideEffect.openCalculateSheet));
    });
    on<OnSideEffectConsumed>((event, emit) async {
      emit(state.copy(sideEffect: SideEffect.nothing));
    });

    on<OnChangeLangClick>((event, emit) async {
      emit(state.copy(sideEffect: SideEffect.openLanguageDialog));
    });

    on<OnCalendarClick>((event, emit) async {
      emit(state.copy(sideEffect: SideEffect.openCalendarDialog));
    });

    on<OnLangChanged>((event, emit) async {
      talker.info(event.newLang);
      emit(state.copy(currentLang: event.newLang));
    });
  }
}
