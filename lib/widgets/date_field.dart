import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    Key? key,
    required this.hintText,
    required this.isWhiteBackground,
    required this.onDateChanged,
    required this.hintColor,
  }) : super(key: key);

  final String hintText;
  final bool isWhiteBackground;
  final bool hintColor;
  final ValueChanged<DateTime>? onDateChanged;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.hintColor ? Colors.grey : Colors.black;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: textWidget(
                    text: _selectedDate == null
                        ? widget.hintText
                        : _selectedDate.toString(),
                    color: textColor,
                  ),
                ),
                Icon(
                  Icons.calendar_month,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateChanged?.call(picked);
    }
  }
}
