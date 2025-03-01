import 'package:flutter/material.dart';

import '../../../data/model/currency_data.dart';

class CurrencyItemExpanded extends StatefulWidget {
  final CurrencyData currencyData;
  final String currentLang;
  final String btnCalculateText;
  final VoidCallback onCalculateClick;
  final VoidCallback onArrowUpClick;

  const CurrencyItemExpanded({
    super.key,
    required this.currencyData,
    required this.currentLang,
    required this.onCalculateClick,
    required this.onArrowUpClick,
    required this.btnCalculateText,
  });

  @override
  State<CurrencyItemExpanded> createState() => _CurrencyItemExpandedState();
}

class _CurrencyItemExpandedState extends State<CurrencyItemExpanded> {
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
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 12),
        child: Column(
          children: [
            Row(
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
                              text: " | 📅 ${widget.currencyData.date}",
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
                  onPressed: widget.onArrowUpClick,
                  icon: Icon(
                    Icons.keyboard_arrow_up_sharp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: widget.onCalculateClick,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color(0xFF76A3B5),
                    ),

                    child: Row(
                      spacing: 4,
                      children: [
                        Icon(Icons.calculate, color: Colors.white),
                        Text(
                          widget.btnCalculateText,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
