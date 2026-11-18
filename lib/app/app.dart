import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_providers.dart';
import 'router/go_router.dart';

class WOrganiceApp extends StatelessWidget {
  const WOrganiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp.router(
        title: 'WOrganice',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}