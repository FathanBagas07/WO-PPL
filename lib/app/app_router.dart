
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/splash_page.dart';
import '../features/auth/providers/auth_provider.dart';

class AppRouter {
  final AuthProvider authProvider;

  late final GoRouter router;

  AppRouter({
    required this.authProvider,
  }) {
    router = GoRouter(
      initialLocation: '/',
      refreshListenable: authProvider,
      redirect: (context, state) {
        final status = authProvider.status;
        final location = state.matchedLocation;

        // Sesi masih diperiksa.
        if (status == AuthStatus.initializing) {
          return location == '/' ? null : '/';
        }

        // Terjadi kesalahan ketika memeriksa autentikasi.
        if (status == AuthStatus.error) {
          return location == '/auth-error'
              ? null
              : '/auth-error';
        }

        // Tidak ada sesi login.
        if (status == AuthStatus.unauthenticated) {
          return location == '/login' ? null : '/login';
        }

        // Pengguna sudah login.
        if (status == AuthStatus.authenticated) {
          final isAdmin = authProvider.isAdmin;
          final isClient = authProvider.isClient;

          // Arahkan dari splash/login ke dashboard sesuai role.
          if (location == '/' || location == '/login') {
            return isAdmin ? '/admin' : '/client';
          }

          // Pengguna yang sudah terautentikasi tidak perlu
          // mengakses halaman error autentikasi.
          if (location == '/auth-error') {
            return isAdmin ? '/admin' : '/client';
          }

          // Admin tidak boleh masuk ke halaman client.
          if (location == '/client' && isAdmin) {
            return '/admin';
          }

          // Client tidak boleh masuk ke halaman admin.
          if (location == '/admin' && isClient) {
            return '/client';
          }
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) {
            return LoginPage(
              onLoginSubmit: (email, password) async {
                await context.read<AuthProvider>().signIn(
                  email: email,
                  password: password,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/admin',
          name: 'admin',
          builder: (context, state) => const AdminPlaceholderPage(),
        ),
        GoRoute(
          path: '/client',
          name: 'client',
          builder: (context, state) => const ClientPlaceholderPage(),
        ),
        GoRoute(
          path: '/auth-error',
          name: 'auth-error',
          builder: (context, state) => const AuthErrorPlaceholderPage(),
        ),
      ],
    );
  }

  void dispose() {
    router.dispose();
  }
}

// Placeholder sementara untuk dashboard admin.

class AdminPlaceholderPage extends StatelessWidget {
  const AdminPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Admin Dashboard - Dalam pengembangan'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _handleSignOut(context),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder sementara untuk dashboard client.

class ClientPlaceholderPage extends StatelessWidget {
  const ClientPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Client Dashboard - Dalam pengembangan'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _handleSignOut(context),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder untuk kegagalan autentikasi.

class AuthErrorPlaceholderPage extends StatelessWidget {
  const AuthErrorPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 56,
              ),
              const SizedBox(height: 16),
              const Text(
                'Autentikasi Bermasalah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                authProvider.errorMessage ??
                    'Terjadi kesalahan saat memeriksa akun.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _handleSignOut(context),
                child: const Text('Kembali ke Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _handleSignOut(BuildContext context) async {
  try {
    await context.read<AuthProvider>().signOut();
  } catch (_) {
    // AuthProvider dan GoRouter menangani perubahan status
    // serta pengalihan ke halaman error autentikasi.
  }
}
