
import 'package:material_ui/material_ui.dart';

import '../../app/app_theme.dart';

enum AppActionButtonType {
  primary,
  secondary,
}

class AppActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  final AppActionButtonType type;
  final bool isLoading;
  final bool enabled;

  const AppActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppActionButtonType.primary,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = type == AppActionButtonType.primary;

    final backgroundColor = isPrimary
        ? WOrganiceColors.primary
        : WOrganiceColors.pale;

    final foregroundColor = isPrimary
        ? WOrganiceColors.white
        : WOrganiceColors.primary;

    return SizedBox(
      width: double.infinity,
      height: WOrganiceSpacing.minTouchTarget,
      child: ElevatedButton(
        onPressed: (!enabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor.withValues(
            alpha: 0.6,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              WOrganiceSpacing.controlRadius,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
      ),
    );
  }
}
