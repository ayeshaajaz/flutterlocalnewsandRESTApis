import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localnews/styles/app_colors.dart';

class KDropdownButton<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T value;
  final ValueChanged onChanged;

  const KDropdownButton({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  }) : assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      child: DropdownButton<T>(
        underline: Container(),
        hint: Text(label),
        isExpanded: true,
        style: TextStyle(
          color: AppColors.titleTextColor,
          fontSize: 16,
        ),
        icon: SvgPicture.asset(
          'assets/images/arrow_right.svg',
          height: 8.9,
          width: 13.86,
        ),
        value: value,
        items: options.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
