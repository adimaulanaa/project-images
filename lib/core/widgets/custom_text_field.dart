import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_text.dart';

class OnlyTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color color;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const OnlyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.color = AppColors.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<OnlyTextField> createState() => _OnlyTextFieldState();
}

class _OnlyTextFieldState extends State<OnlyTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() {
    // Memastikan State objek masih terpasang (mounted) sebelum memanggil setState()
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colors = widget.color.withValues(alpha: 0.7);
    final Color enabledColor = widget.controller.text.isEmpty
        ? AppColors.border
        : colors;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        errorText: widget.errorText,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.color, width: 2),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isLabel;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color color;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.isLabel = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.color = AppColors.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colors = widget.color.withValues(alpha: 0.7);
    final Color enabledColor = widget.controller.text.isEmpty
        ? AppColors.border
        : colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isLabel
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.label,
                  style: blackTextstyle.copyWith(
                    fontSize: 15,
                    fontWeight: medium,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            errorText: widget.errorText,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: enabledColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: widget.color, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final String label; // label di atas
  final String hintText; // hint text di field
  final IconData prefixIcon; // icon di kiri
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText; // untuk password field
  final Widget? suffixIcon; // icon kanan opsional
  final Color borderColor;
  final Color focusedBorderColor;

  const PasswordTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.borderColor = AppColors.primary,
    this.focusedBorderColor = AppColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: blackTextstyle.copyWith(fontSize: 15, fontWeight: medium),
          ),
        ),
        const SizedBox(height: 6),
        // TextFormField
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon,
            hintText: hintText,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: focusedBorderColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class MultiLineField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Color borderColor;

  const MultiLineField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onChanged,
    this.borderColor = AppColors.primary,
  });

  @override
  State<MultiLineField> createState() => _MultiLineFieldState();
}

class _MultiLineFieldState extends State<MultiLineField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colors = widget.borderColor.withValues(alpha: 0.5);
    final Color enabledColor = widget.controller.text.isEmpty
        ? AppColors.border
        : colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: blackTextstyle.copyWith(fontSize: 15, fontWeight: medium),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          keyboardType: TextInputType.multiline,
          maxLines: null, // biar auto wrap ke bawah
          minLines: 3, // minimal tinggi 3 baris
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: enabledColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: widget.borderColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
