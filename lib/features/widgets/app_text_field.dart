
import 'package:material_ui/material_ui.dart';

import '../../app/app_theme.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  final bool isPassword;
  final bool enabled;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.isPassword = false,
    this.enabled = true,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final obscureText = widget.isPassword && !_isPasswordVisible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: WOrganiceColors.ink,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: WOrganiceSpacing.xs),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          obscureText: obscureText,
          enabled: widget.enabled,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: WOrganiceColors.ink,
              ),
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: WOrganiceSpacing.md,
              vertical: WOrganiceSpacing.sm,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _isPasswordVisible
                        ? 'Sembunyikan kata sandi'
                        : 'Tampilkan kata sandi',
                    onPressed: widget.enabled
                        ? () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          }
                        : null,
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: WOrganiceColors.muted,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
