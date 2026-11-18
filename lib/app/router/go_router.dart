import 'package:go_router/go_router.dart';

import '../../presentation/shared/pages/home_page.dart';
import '../../presentation/admin/pages/admin_page.dart';
import '../../presentation/client/pages/client_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminPage(),
    ),
    GoRoute(
      path: '/client',
      builder: (context, state) => const ClientPage(),
    ),
  ],
);