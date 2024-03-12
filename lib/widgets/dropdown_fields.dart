import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithDropdown extends StatefulWidget {
  const CustomTextFieldWithDropdown({
    Key? key,
    required this.isWhiteBackground,
    required this.dropdownItems,
    required this.onDropdownChanged,
    this.hintText,
    this.initialValue,
  }) : super(key: key);

  final bool isWhiteBackground;
  final List<String> dropdownItems;
  final ValueChanged<String>? onDropdownChanged;
  final String? hintText;
  final String? initialValue;

  @override
  State<CustomTextFieldWithDropdown> createState() =>
      _CustomTextFieldWithDropdownState();
}

class _CustomTextFieldWithDropdownState
    extends State<CustomTextFieldWithDropdown> {
  String? _selectedDropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: DropdownButton<String?>(
            value: _selectedDropdownValue,
            disabledHint: SizedBox(),
            hint: textWidget(text: '${widget.hintText}'),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.green,
            ),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
            style: TextStyle(
              color: Colors.grey,
            ),
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDropdownValue = newValue;
              });
              if (widget.onDropdownChanged != null && newValue != null) {
                widget.onDropdownChanged!(newValue);
              }
            },
            items: [
              // '${widget.initialDropdownValue}',
              ...widget.dropdownItems,
            ].map<DropdownMenuItem<String?>>((String value) {
              print(value);
              return DropdownMenuItem<String?>(
                value: value,
                child: textWidget(
                  text: value,
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
