
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl({
    required this._dataSource,
  });

  @override
  Stream<AppUser?> authStateChanges() {
    return _dataSource.authStateChanges();
  }

  @override
  Future<AppUser?> getCurrentUser() {
    return _dataSource.getCurrentUser();
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) {
    return _dataSource.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }
}