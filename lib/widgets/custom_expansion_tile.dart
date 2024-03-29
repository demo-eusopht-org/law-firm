import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> actions;
  final List<Widget> children;
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.actions = const [],
    required this.children,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: SizedBox(
            height: _isExpanded ? null : 0.0,
            child: Column(
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: () {
        _isExpanded = !_isExpanded;
        setState(() {});
      },
      child: Row(
        children: [
          Expanded(
            child: widget.title,
          ),
          for (final action in widget.actions) action,
          AnimatedRotation(
            turns: _isExpanded ? -0.5 : -1,
            duration: const Duration(milliseconds: 250),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.green,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
