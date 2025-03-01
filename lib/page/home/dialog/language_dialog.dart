import 'package:flutter/material.dart';

class LanguageDialog extends StatefulWidget {
  final String currentLang;
  final ValueChanged<String> onLangChange;

  const LanguageDialog({
    super.key,
    required this.currentLang,
    required this.onLangChange,
  });

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late String _selectedLang;

  @override
  void initState() {
    super.initState();
    _selectedLang = widget.currentLang;
  }

  void _onLangSelected(String lang) {
    setState(() {
      _selectedLang = lang;
    });
    widget.onLangChange(lang);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRadioTile('uz', 'Oʻzbek'),
          _buildRadioTile('ru', 'Русский'),
          _buildRadioTile('en', 'English'),
        ],
      ),
    );
  }

  Widget _buildRadioTile(String lang, String title) {
    return RadioListTile<String>(
      value: lang,
      groupValue: _selectedLang,
      onChanged: (value) {
        if (value != null) _onLangSelected(value);
      },
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
      ),
      activeColor: Colors.white,
    );
  }
}
