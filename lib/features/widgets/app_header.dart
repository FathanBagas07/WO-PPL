
import 'package:material_ui/material_ui.dart';

import '../../app/app_theme.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        WOrganiceSpacing.lg,
        WOrganiceSpacing.lg,
        WOrganiceSpacing.lg,
        WOrganiceSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: WOrganiceColors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(WOrganiceSpacing.cardRadius),
        ),
        border: Border(
          bottom: BorderSide(
            color: WOrganiceColors.line,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: WOrganiceColors.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: WOrganiceSpacing.xxs),
          Text(
            subtitle.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: WOrganiceColors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
          ),
        ],
      ),
    );
  }
}
