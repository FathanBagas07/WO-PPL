
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';

class AuthDataException implements Exception {
  final String message;

  const AuthDataException(this.message);

  @override
  String toString() => message;
}

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthDataSource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Mendengarkan perubahan sesi Firebase Authentication
  /// sekaligus perubahan dokumen profil pengguna di Firestore.
  Stream<AppUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().asyncExpand((firebaseUser) {
      if (firebaseUser == null) {
        return Stream<AppUser?>.value(null);
      }

      return _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .snapshots()
          .map((snapshot) {
        return _mapUserDocument(snapshot, firebaseUser);
      });
    });
  }

  /// Mengambil profil pengguna yang sedang login.
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    return _mapUserDocument(snapshot, firebaseUser);
  }

  /// Login menggunakan email dan password.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Logout dari Firebase Authentication.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Mengonversi dokumen Firestore menjadi AppUser.
  AppUser _mapUserDocument(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    User firebaseUser,
  ) {
    if (!snapshot.exists) {
      throw const AuthDataException(
        'Profil pengguna tidak ditemukan.',
      );
    }

    final data = snapshot.data();

    if (data == null) {
      throw const AuthDataException(
        'Data profil pengguna kosong.',
      );
    }

    final email = data['email'];
    final role = data['role'];
    final status = data['status'];
    final createdAt = data['created_at'];

    if (email is! String ||
        role is! String ||
        status is! String) {
      throw const AuthDataException(
        'Format data profil pengguna tidak valid.',
      );
    }

    if (firebaseUser.email == null ||
        email.trim().toLowerCase() !=
            firebaseUser.email!.trim().toLowerCase()) {
      throw const AuthDataException(
        'Email akun tidak sesuai dengan profil pengguna.',
      );
    }

    DateTime createdAtDate;

    if (createdAt is Timestamp) {
      createdAtDate = createdAt.toDate();
    } else if (createdAt is DateTime) {
      createdAtDate = createdAt;
    } else {
      throw const AuthDataException(
        'Format created_at tidak valid.',
      );
    }

    return AppUser.fromMap(
      firebaseUser.uid,
      {
        ...data,
        'created_at': createdAtDate,
      },
    );
  }
}