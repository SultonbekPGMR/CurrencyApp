import 'package:currency_app_sultonbek/page/home/widget/app_text_field.dart';
import 'package:flutter/material.dart';

class CalculatorDialog extends StatefulWidget {
  final String title;
  final String shortNameFrom;
  final double rate;
  final String shortNameTo = 'UZS';

  const CalculatorDialog({
    super.key,
    required this.title,
    required this.rate,
    required this.shortNameFrom,
  });

  @override
  State<CalculatorDialog> createState() => _CalculatorDialogState();
}

class _CalculatorDialogState extends State<CalculatorDialog> {
  final TextEditingController _controllerFrom = TextEditingController();
  final TextEditingController _controllerTo = TextEditingController();
  bool _isSwapped = false;

  void onInputChange(String text) {
    if (text.isEmpty) {
      _controllerTo.text = '';
      return;
    }

    final sum =
        _isSwapped
            ? double.parse(text) / widget.rate
            : double.parse(text) * widget.rate;

    _controllerTo.text = sum.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E293B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              width: 50,
              height: 6,
              decoration: BoxDecoration(
                color: Color(0xFF76A3B5).withOpacity(0.4),
                // Change color as needed
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            SizedBox(height: 8),

            Text(
              widget.title,
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),

            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      AppTextField(
                        _isSwapped ? widget.shortNameTo : widget.shortNameFrom,
                        onInputChange,
                        controller: _controllerFrom,
                      ),
                      AppTextField(
                        _isSwapped ? widget.shortNameFrom : widget.shortNameTo,
                        isReadOnly: true,

                        (text) {},
                        controller: _controllerTo,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 49,
                  right: 16,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isSwapped = !_isSwapped;
                        onInputChange(_controllerFrom.text);
                      });
                    },
                    icon: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1E293B),
                      ),
                      child: Icon(
                        Icons.swap_vert_circle,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
