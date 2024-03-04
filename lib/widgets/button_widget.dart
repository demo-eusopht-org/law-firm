import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double borderRadius;
  final bool loading;

  RoundedElevatedButton({
    required this.onPressed,
    required this.text,
    this.borderRadius = 20.0,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ), // Rounded corners
        ),
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(
          horizontal: 18.0,
          // vertical: 12.0,
        ),
        fixedSize: Size(
          MediaQuery.of(context).size.width,
          50,
        ),
      ),
      onPressed: onPressed,
      child: loading
          ? SizedBox(
              height: 35,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : textWidget(
              text: text,
              color: Colors.white,
              fWeight: FontWeight.w700,
              fSize: 15.0,
            ),
    );
  }
}
