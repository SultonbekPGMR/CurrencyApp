import 'package:currency_app_sultonbek/page/home/dialog/calculater_dialog.dart';
import 'package:currency_app_sultonbek/page/home/widget/currency_item.dart';
import 'package:currency_app_sultonbek/page/home/widget/currency_item_expanded.dart';
import 'package:currency_app_sultonbek/page/home/widget/expandable_container.dart';
import 'package:currency_app_sultonbek/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog/language_dialog.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _selectDate(String currentLang) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: Locale(currentLang),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              surface: Color(0xFF1E293B),
              primary: Colors.white,
              onPrimary: Color(0xFF031F2B),
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Color(0xFF031F2B)),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      context.read<HomeBloc>().add(
        GetCurrencyForSelectedDate(
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          context.showSnackBar(state.errorMessage ?? 'Unknown error!');
        }

        switch (state.sideEffect) {
          case SideEffect.nothing:
            {}
          case SideEffect.openCalculateSheet:
            {
              final data = state.currencyList[state.expandedItemIndex];
              context.read<HomeBloc>().add(OnSideEffectConsumed());
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return CalculatorDialog(
                    rate: double.parse(data.rate),
                    title: data.names[state.currentLang] ?? '',
                    shortNameFrom: data.ccy,
                  );
                },
              );
            }
          case SideEffect.openCalendarDialog:
            {
              context.read<HomeBloc>().add(OnSideEffectConsumed());
              _selectDate(state.currentLang);
            }
          case SideEffect.openLanguageDialog:
            {
              context.read<HomeBloc>().add(OnSideEffectConsumed());
              final parentContext = context; // Store the parent context

              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (bottomSheetContext) {
                  return LanguageDialog(
                    currentLang: state.currentLang,
                    onLangChange: (newLang) {
                      Navigator.pop(context);
                      parentContext.read<HomeBloc>().add(
                        OnLangChanged(newLang),
                      );
                    },
                  );
                },
              );
            }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF031F2B),
          body: switch (state.status) {
            Status.loading => Center(
              child: CircularProgressIndicator(color: Color(0xFF76A3B5)),
            ),
            Status.success => CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Color(0xFF031F2B).withOpacity(0.99),
                  expandedHeight: 90,
                  stretch: true,
                  pinned: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(OnCalendarClick());
                      },
                      icon: Icon(Icons.calendar_month, color: Colors.white),
                    ),

                    Container(
                      transform: Matrix4.translationValues(-8, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(OnChangeLangClick());
                        },
                        icon: Icon(
                          Icons.language_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      return FlexibleSpaceBar(
                        expandedTitleScale: 1.4,
                        centerTitle: true,
                        collapseMode: CollapseMode.pin,
                        title: Row(
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                state.title[state.currentLang] ?? 'Currency',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.currencyList.length,
                    (context, index) {
                      return ExpandableCardContainer(
                        key: ValueKey(index),
                        isExpanded: state.expandedItemIndex == index,
                        collapsedChild: CurrencyItem(
                          currencyData: state.currencyList[index],
                          currentLang: state.currentLang,
                          onArrowDownClick: () {
                            context.read<HomeBloc>().add(
                              OnItemExpandClick(index),
                            );
                          },
                        ),
                        expandedChild: CurrencyItemExpanded(
                          btnCalculateText:
                              state.btnCalculateText[state.currentLang] ??
                              'Calculate',
                          currencyData: state.currencyList[index],
                          currentLang: state.currentLang,
                          onArrowUpClick: () {
                            context.read<HomeBloc>().add(
                              OnItemCollapseClick(index),
                            );
                          },
                          onCalculateClick: () {
                            context.read<HomeBloc>().add(OnCalculateClick());
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Status.error => Container(),
          },
        );
      },
    );
  }
}
