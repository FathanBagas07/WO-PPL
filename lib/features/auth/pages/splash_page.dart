
import 'package:material_ui/material_ui.dart';

import '../../widgets/worganice_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: WOrganiceLogo(
            size: 112,
          ),
        ),
      ),
    );
  }
}
