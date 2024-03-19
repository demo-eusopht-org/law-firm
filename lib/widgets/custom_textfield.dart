import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.showPasswordHideButton = false,
    required this.hintText,
    required this.isWhiteBackground,
    this.controller,
    this.enabled,
    this.validatorCondition,
    this.textInputType,
    this.maxlines,
    this.readonly = false,
    this.onTap,
  });

  final bool showPasswordHideButton;
  final String hintText;
  final bool isWhiteBackground;
  final bool? enabled;
  final String? Function(String?)? validatorCondition;
  final textInputType;
  final int? maxlines;
  final bool readonly;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.isWhiteBackground ? Colors.black : Colors.white;
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readonly,
      controller: widget.controller,
      validator: widget.validatorCondition,
      keyboardType: widget.textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      maxLines: widget.maxlines,
      style: TextStyle(
        color: textColor,
      ),
      obscureText: isPasswordHidden && widget.showPasswordHideButton,
      enabled: widget.enabled,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 30, left: 10),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.mulish(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 35,
          // maxWidth: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        suffixIcon: widget.showPasswordHideButton
            ? IconButton(
                constraints: BoxConstraints(
                  maxHeight: 35,
                  maxWidth: 40,
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  tapTargetSize: MaterialTapTargetSize.padded,
                ),
                icon: Icon(
                  isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  size: 22,
                  color: Colors.green,
                  // opticalSize: 1,
                ),
                onPressed: () {
                  isPasswordHidden = !isPasswordHidden;
                  print('HIDDEN: $isPasswordHidden');
                  setState(() {});
                },
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
