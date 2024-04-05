import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.showPasswordHideButton = false,
    this.hintText,
    this.label,
    required this.isWhiteBackground,
    this.labelColor,
    this.controller,
    this.enabled,
    this.validatorCondition,
    this.textInputType,
    this.maxLines,
    this.readonly = false,
    this.suffix,
    this.onTap,
  }) : assert(hintText != null || label != null);

  final bool showPasswordHideButton;
  final String? hintText;
  final String? label;
  final bool isWhiteBackground;
  final bool? enabled;
  final Color? labelColor;
  final String? Function(String?)? validatorCondition;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool readonly;
  final Widget? suffix;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordHidden = true;
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.isWhiteBackground ? Colors.black : Colors.white;
    return TextFormField(
      focusNode: _focusNode,
      onTap: widget.onTap,
      readOnly: widget.readonly,
      controller: widget.controller,
      validator: widget.validatorCondition,
      keyboardType: widget.textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      maxLines: widget.maxLines,
      style: TextStyle(
        color: textColor,
      ),
      obscureText: isPasswordHidden && widget.showPasswordHideButton,
      enabled: widget.enabled,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 30, left: 10),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.mulish(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        labelText: widget.label,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 35,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelStyle: widget.labelColor != null
            ? TextStyle(
                color: widget.labelColor,
              )
            : null,
        suffixIcon: _getSuffixIcon(),
      ),
    );
  }

  Widget _getSuffixIcon() {
    if (widget.showPasswordHideButton) {
      return IconButton(
        constraints: const BoxConstraints(
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
      );
    } else if (widget.suffix != null) {
      return widget.suffix!;
    }
    return const SizedBox.shrink();
  }
}
