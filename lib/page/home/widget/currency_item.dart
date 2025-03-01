import 'package:flutter/material.dart';

import '../../../data/model/currency_data.dart';

class CurrencyItem extends StatefulWidget {
  final CurrencyData currencyData;
  final String currentLang;
  final VoidCallback onArrowDownClick;

  const CurrencyItem({
    super.key,
    required this.currencyData,
    required this.currentLang,
    required this.onArrowDownClick,
  });

  @override
  State<CurrencyItem> createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.currencyData.names[widget.currentLang],
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),

                      children: [
                        TextSpan(
                          text:
                              '  ${double.parse(widget.currencyData.diff) > 0 ? '+' : ''}${widget.currencyData.diff}',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                double.parse(widget.currencyData.diff) > 0
                                    ? Colors.green
                                    : Colors.red,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "1 ${widget.currencyData.ccy} ➞ ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "${widget.currencyData.rate} UZS"
                              "",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text:
                              " | 📅 ${widget.currencyData.date}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: widget.onArrowDownClick,
              icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
