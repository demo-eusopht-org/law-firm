import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.hintText,
    required this.isWhiteBackground,
    required this.onDateChanged,
    required this.hintColor,
    this.dateFormat,
    this.initialDate,
  });

  final String hintText;
  final bool isWhiteBackground;
  final bool hintColor;
  final DateTime? initialDate;
  final DateFormat? dateFormat;
  final ValueChanged<DateTime>? onDateChanged;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
      if (widget.dateFormat != null) {
        _dateController.text = widget.dateFormat!.format(widget.initialDate!);
      } else {
        _dateController.text = widget.initialDate!.getFormattedDateTime();
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.hintColor ? Colors.grey : const Color(0xff424940);
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: SizedBox(
        height: 56,
        child: TextFormField(
          controller: _dateController,
          decoration: InputDecoration(
            border: _buildBorder(),
            focusedBorder: _buildBorder(),
            enabledBorder: _buildBorder(),
            disabledBorder: _buildBorder(),
            label: textWidget(
              text: widget.hintText,
              color: textColor,
            ),
            suffixIcon: const Icon(
              Icons.calendar_month,
              color: Colors.green,
            ),
          ),
          enabled: false,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(20.0),
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
      _selectedDate = picked;
      if (widget.dateFormat != null) {
        _dateController.text = widget.dateFormat!.format(picked);
      } else {
        _dateController.text = picked.getFormattedDateTime();
      }
      widget.onDateChanged?.call(picked);
    }
  }
}
