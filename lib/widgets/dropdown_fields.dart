import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithDropdown<T> extends StatefulWidget {
  const CustomTextFieldWithDropdown({
    super.key,
    required this.isWhiteBackground,
    required this.dropdownItems,
    required this.onDropdownChanged,
    required this.builder,
    this.initialValue,
    this.hintText,
  });

  final bool isWhiteBackground;
  final T? initialValue;
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.initialValue != null) {
        _selectedDropdownValue = widget.initialValue;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: DropdownButtonFormField<T?>(
        value: _selectedDropdownValue,
        disabledHint: const SizedBox(),
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
        decoration: InputDecoration(
          constraints: const BoxConstraints(
            minHeight: 40,
          ),
          isDense: false,
          label: textWidget(
            text: '${widget.hintText}',
            fWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
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
    );
  }
}
