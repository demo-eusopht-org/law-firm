import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithDropdown<T> extends StatefulWidget {
  const CustomTextFieldWithDropdown({
    super.key,
    required this.isWhiteBackground,
    required this.dropdownItems,
    required this.onDropdownChanged,
    required this.builder,
    this.hintText,
  });

  final bool isWhiteBackground;
  final List<T> dropdownItems;
  final Widget Function(T value) builder;
  final ValueChanged<T>? onDropdownChanged;
  final String? hintText;

  @override
  State<CustomTextFieldWithDropdown<T>> createState() =>
      _CustomTextFieldWithDropdownState<T>();
}

class _CustomTextFieldWithDropdownState<T>
    extends State<CustomTextFieldWithDropdown<T>> {
  T? _selectedDropdownValue;

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
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: DropdownButton<T?>(
            value: _selectedDropdownValue,
            disabledHint: const SizedBox(),
            hint: textWidget(
              text: '${widget.hintText}',
              fWeight: FontWeight.bold,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.green,
            ),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
            style: const TextStyle(
              color: Colors.grey,
            ),
            underline: const SizedBox(),
            onChanged: (T? newValue) {
              setState(() {
                _selectedDropdownValue = newValue;
              });
              if (widget.onDropdownChanged != null && newValue != null) {
                widget.onDropdownChanged!(newValue);
              }
            },
            items: <DropdownMenuItem<T>>[
              for (T item in widget.dropdownItems)
                DropdownMenuItem<T>(
                  value: item,
                  child: widget.builder(item),
                ),
            ],
            // items: widget.dropdownItems.map<DropdownMenuItem<T>>((T value) {
            //   return DropdownMenuItem<T>(
            //     value: value,
            //     child: widget.builder(value),
            //   );
            // }).toList(),
          ),
        ),
      ],
    );
  }
}
