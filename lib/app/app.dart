
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../data/datasources/firebase_auth_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../features/auth/providers/auth_provider.dart';
import 'app_router.dart';
import 'app_theme.dart';

class WOrganiceApp extends StatefulWidget {
  const WOrganiceApp({super.key});

  @override
  State<WOrganiceApp> createState() => _WOrganiceAppState();
}

class _WOrganiceAppState extends State<WOrganiceApp> {
  late final AuthProvider _authProvider;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    final dataSource = FirebaseAuthDataSource();

    final authRepository = AuthRepositoryImpl(
      dataSource: dataSource,
    );

    _authProvider = AuthProvider(
      authRepository: authRepository,
    );

    _appRouter = AppRouter(
      authProvider: _authProvider,
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    _authProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: _authProvider,
      child: MaterialApp.router(
        title: 'WOrganice',
        debugShowCheckedModeBanner: false,
        theme: WOrganiceTheme.lightTheme,
        routerConfig: _appRouter.router,
      ),
    );
  }
}