
import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../domain/entities/app_user.dart';
import '../../../domain/repositories/auth_repository.dart';

enum AuthStatus {
  initializing,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  static const Duration _minimumSplashDuration =
    Duration(seconds: 2);

  final Stopwatch _startupStopwatch = Stopwatch()..start();

  StreamSubscription<AppUser?>? _authSubscription;

  AuthStatus _status = AuthStatus.initializing;
  AppUser? _currentUser;

  bool _isSigningIn = false;
  bool _isSigningOut = false;

  String? _errorMessage;

  AuthProvider({
    required this._authRepository,
  }) {
    _listenToAuthChanges();
  }

  // Getters

  AuthStatus get status => _status;

  AppUser? get currentUser => _currentUser;

  bool get isSigningIn => _isSigningIn;

  bool get isSigningOut => _isSigningOut;

  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _status == AuthStatus.authenticated;

  bool get isInitializing => _status == AuthStatus.initializing;

  bool get isUnauthenticated => _status == AuthStatus.unauthenticated;

  bool get hasError => _status == AuthStatus.error;

  bool get isAdmin => _currentUser?.isAdmin ?? false;

  bool get isClient => _currentUser?.isClient ?? false;

  // Mendengarkan perubahan sesi autentikasi.

  
  void _listenToAuthChanges() {
    _authSubscription = _authRepository.authStateChanges().listen(
      (user) async {
        final elapsed = _startupStopwatch.elapsed;
        final remaining = _minimumSplashDuration - elapsed;
  
        if (remaining > Duration.zero) {
          await Future.delayed(remaining);
        }
  
        _errorMessage = null;
  
        if (user == null) {
          _currentUser = null;
          _status = AuthStatus.unauthenticated;
        } else if (!user.isActive) {
          _currentUser = null;
          _status = AuthStatus.error;
          _errorMessage =
              'Akun Anda tidak aktif. Silakan hubungi administrator.';
        } else {
          _currentUser = user;
          _status = AuthStatus.authenticated;
        }
  
        notifyListeners();
      },
      onError: (Object error, StackTrace stackTrace) {
        _currentUser = null;
        _status = AuthStatus.error;
        _errorMessage =
            'Gagal memeriksa sesi pengguna. Periksa koneksi internet '
            'dan coba kembali.';
  
        notifyListeners();
      },
    );
  }

  // Login.

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (_isSigningIn) return;

    _isSigningIn = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.signIn(
        email: email,
        password: password,
      );
    } catch (error) {
      _errorMessage =
          'Login gagal. Periksa kembali email dan password Anda.';
      rethrow;
    } finally {
      _isSigningIn = false;
      notifyListeners();
    }
  }

  // Logout.

  Future<void> signOut() async {
    if (_isSigningOut) return;

    _isSigningOut = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.signOut();
    } catch (error) {
      _errorMessage = 'Gagal keluar dari akun. Silakan coba kembali.';
      rethrow;
    } finally {
      _isSigningOut = false;
      notifyListeners();
    }
  }

  // Membersihkan pesan error.

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}