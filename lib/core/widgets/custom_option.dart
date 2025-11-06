import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';
import 'package:my_gallery/core/media/media_text.dart';

class CircularCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final Duration duration;
  final bool showShadow;
  final BorderRadius? borderRadius; // untuk safety jika butuh

  const CircularCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 28.0,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.duration = const Duration(milliseconds: 220),
    this.showShadow = true,
    this.borderRadius,
  });

  @override
  State<CircularCheckbox> createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.value ? 1.0 : 0.0,
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void didUpdateWidget(covariant CircularCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onChanged == null) return; // disabled
    widget.onChanged!(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = widget.activeColor ?? AppColors.primary;
    final Color checkColor = widget.checkColor ?? Colors.white;
    final Color borderColor = widget.borderColor ?? AppColors.primary;
    final double size = widget.size;
    final bool disabled = widget.onChanged == null;

    return Semantics(
      container: true,
      button: true,
      checked: widget.value,
      enabled: !disabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        child: SizedBox(
          width: size,
          height: size,
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer circle (border or filled)
                  AnimatedContainer(
                    duration: widget.duration,
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.value ? activeColor : Colors.transparent,
                      border: widget.value
                          ? null
                          : Border.all(
                              color: disabled
                                  ? borderColor.withValues(alpha: 0.45)
                                  : borderColor,
                              width: 1.6,
                            ),
                      boxShadow: widget.value && widget.showShadow
                          ? [
                              BoxShadow(
                                color: activeColor.withValues(alpha: 0.18),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                  ),

                  // Check icon (scale animation)
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: AnimatedOpacity(
                      opacity: widget.value ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        Icons.check,
                        size: size * 0.56,
                        color: checkColor,
                      ),
                    ),
                  ),

                  // Optional overlay when disabled
                  if (disabled)
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.0),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class RoundedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double width;
  final double height;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final double borderRadius;
  final Duration duration;

  const RoundedCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 25,
    this.height = 25,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.borderRadius = 8, // biar agak “pill” tapi bukan bulat total
    this.duration = const Duration(milliseconds: 200),
  });

  void _handleTap() {
    if (onChanged != null) onChanged!(!value);
  }

  @override
  Widget build(BuildContext context) {
    final Color active = activeColor ?? AppColors.primary;
    final Color check = checkColor ?? Colors.white;
    final Color border = borderColor ?? AppColors.primary;
    final bool disabled = onChanged == null;

    return GestureDetector(
      onTap: disabled ? null : _handleTap,
      child: AnimatedContainer(
        duration: duration,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: value ? active : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: value
              ? null
              : Border.all(
                  color: disabled ? border.withValues(alpha: 0.3) : border,
                  width: 1.6,
                ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: value ? 1.0 : 0.0,
          child: Icon(Icons.check, size: width * 0.80, color: check),
        ),
      ),
    );
  }
}

class CustomDropdownField<T> extends StatelessWidget {
  // Properti untuk Label
  final String label;
  final bool isLabel;

  // Properti Dropdown (Value & Items)
  final T? value; // Tipe generik T agar fleksibel
  final List<String> items;
  final ValueChanged<T?>? onChanged;
  
  // Properti Tampilan
  final String hintText;
  final IconData? prefixIcon;
  final Color color; // Warna utama, biasanya AppColors.primary
  final String? errorText;
  final FormFieldValidator<T>? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText = 'Pilih Opsi',
    this.isLabel = true,
    this.prefixIcon,
    this.color = AppColors.primary, // Nilai default AppColors.primary
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan warna border berdasarkan apakah nilai sudah dipilih atau belum
    final Color primaryColor = color.withValues(alpha: 0.7);
    final Color enabledColor = value == null 
        ? AppColors.border 
        : primaryColor;
        
    return Padding(
     padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Label
          if (isLabel)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: blackTextstyle.copyWith(
                  fontSize: 15,
                  fontWeight: medium,
                ),
              ),
            ),
          const SizedBox(height: 6),
          DropdownButtonFormField<T>(
            initialValue: value,
            items: items.map((String item) {
              return DropdownMenuItem<T>(
                value: item as T,
                child: Text(
                  item,
                  style: blackTextstyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
            dropdownColor: AppColors.background,
            
            // Custom Hint Text
            hint: Text(
              hintText,
              style: TextStyle(
                color: AppColors.muted, // Warna muted/abu-abu untuk hint
              ),
            ),
            decoration: InputDecoration(
              errorText: errorText,
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 30,
              ),
              
              // Border saat tidak focus
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: enabledColor),
              ),
              
              // Border saat focus
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: color, width: 2),
              ),
              
              // Border saat Error
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.error, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.error, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
