
import 'package:material_ui/material_ui.dart';

import '../../app/app_theme.dart';

class WOrganiceLogo extends StatelessWidget {
  final double iconSize;
  final bool showBrandName;
  final String brandName;
  final double spacing;
  final MainAxisAlignment alignment;
  final Color? iconColor;
  final Color? textColor;

  const WOrganiceLogo({
    super.key,
    this.iconSize = 96,
    this.showBrandName = true,
    this.brandName = 'WOrganice',
    this.spacing = WOrganiceSpacing.md,
    this.alignment = MainAxisAlignment.center,
    this.iconColor,
    this.textColor, required int size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        Icon(
          Icons.spa_outlined,
          size: iconSize,
          color: iconColor ?? WOrganiceColors.primary,
        ),
        if (showBrandName) ...[
          SizedBox(height: spacing),
          Text(
            brandName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: textColor ?? WOrganiceColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ],
    );
  }
}