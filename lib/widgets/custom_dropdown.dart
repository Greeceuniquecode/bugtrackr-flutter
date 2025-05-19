import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> values;
  final void Function(String)? onSelected;
  const CustomDropdown({required this.values, this.onSelected, super.key});
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      dropdownColor: Colors.blue.shade800,
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