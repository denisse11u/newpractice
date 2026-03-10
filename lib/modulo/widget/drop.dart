import 'package:flutter/material.dart';
import 'package:viadoc_app/env/theme/app_theme.dart';

class DropdownFormFieldWidget<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hintText;
  final String? Function(T?)? validator;
  final Widget? prefixIcon;
  final double borderRadius;
  final Color colorBorder;
  final double borderWith;
  final double verticalPadding;
  final double horizontalPadding;
  final Color fillColor;

  const DropdownFormFieldWidget({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.borderRadius = 10,
    this.colorBorder = AppTheme.textSecondary,
    this.borderWith = 1,
    this.verticalPadding = 12,
    this.horizontalPadding = 10,
    this.fillColor = AppTheme.white,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.hinText),
        prefixIcon: prefixIcon,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: borderWith, color: colorBorder),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWith, color: colorBorder),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppTheme.textPrimary),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWith, color: AppTheme.error),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWith, color: AppTheme.error),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorStyle: const TextStyle(color: AppTheme.error, fontSize: 12),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
