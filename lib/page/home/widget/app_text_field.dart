import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
    this.hint,
    this.onTextChange, {
    super.key,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.number,
    this.text = "",
    this.isPassword = false,
    this.isReadOnly = false,
    this.isPhoneNumber = false,
    this.paddingBottom = 20.0,
    required this.controller,
  });

  final TextEditingController controller;
  final String hint;
  final String text;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPhoneNumber;
  final bool isReadOnly;
  final double paddingBottom;
  final void Function(String) onTextChange;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isEmpty = true;
  bool isObscured = true;

  @override
  void initState() {
    super.initState();

    widget.controller.text = widget.text;
    isEmpty = widget.text.isEmpty;

    widget.controller.addListener(() {
      setState(() {
        isEmpty = widget.controller.text.isEmpty;
      });
      widget.onTextChange.call(widget.controller.text);
    });

    // If it's a phone number, set the initial text to "+998 " if empty
    if (widget.isPhoneNumber && widget.controller.text.isEmpty) {
      widget.controller.text = "+";
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.paddingBottom),
      child: TextField(
        readOnly: widget.isReadOnly,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        keyboardType:
            widget.isPhoneNumber ? TextInputType.phone : widget.keyboardType,
        obscureText: widget.isPassword ? isObscured : false,
        inputFormatters: widget.isPhoneNumber
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'^\+?\d{0,12}$')),
                LengthLimitingTextInputFormatter(13), // Max 13 characters
              ]
            : [],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          label: Text(widget.hint, style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),),
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          suffixIcon: _buildSuffixIcon(),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: (isObscured)
            ? Icon(
                Icons.visibility_outlined,
                color: Colors.white,
              )
            : Icon(
                Icons.visibility_off_outlined,
                color: Colors.white,
              ),
        onPressed: () {
          setState(() {
            isObscured = !isObscured;
          });
        },
      );
    } else if (!isEmpty) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          widget.controller.clear();
        },
      );
    }
    return null;
  }
}
