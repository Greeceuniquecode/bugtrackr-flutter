import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> values;
  final void Function(String)? onSelected;
  final Color? color;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomDropdown({
    required this.values,
    this.onSelected,
    this.color,
    this.backgroundColor,
    this.textStyle,
    super.key,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.values.isNotEmpty ? widget.values.first : '';
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.values.contains(selectedValue)) {
      // Reset selectedValue if current value is no longer valid
      setState(() {
        selectedValue = widget.values.isNotEmpty ? widget.values.first : '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.values.contains(selectedValue) ? selectedValue : null,
      style: widget.textStyle ??
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
      icon: Icon(Icons.arrow_drop_down, color: widget.color ?? Colors.white),
      dropdownColor: widget.backgroundColor ?? Colors.blue.shade800,
      borderRadius: BorderRadius.circular(6),
      underline: const SizedBox(),
      items: widget.values.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(e),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() => selectedValue = newValue);
          widget.onSelected?.call(newValue);
        }
      },
    );
  }
}
