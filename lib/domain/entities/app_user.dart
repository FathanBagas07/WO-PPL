
enum UserRole {
  adminWo,
  client,
}

enum UserStatus {
  active,
  inactive,
}

class AppUser {
  final String userId;
  final String email;
  final UserRole role;
  final UserStatus status;
  final DateTime createdAt;

  const AppUser({
    required this.userId,
    required this.email,
    required this.role,
    required this.status,
    required this.createdAt,
  });

  bool get isActive => status == UserStatus.active;

  bool get isAdmin => role == UserRole.adminWo;

  bool get isClient => role == UserRole.client;

  factory AppUser.fromMap(
    String userId,
    Map<String, dynamic> data,
  ) {
    return AppUser(
      userId: userId,
      email: data['email'] as String,
      role: _parseRole(data['role'] as String),
      status: _parseStatus(data['status'] as String),
      createdAt: (data['created_at'] as DateTime),
    );
  }

  static UserRole _parseRole(String value) {
    switch (value) {
      case 'admin_wo':
        return UserRole.adminWo;
      case 'client':
        return UserRole.client;
      default:
        throw FormatException('Role pengguna tidak valid: $value');
    }
  }

  static UserStatus _parseStatus(String value) {
    switch (value) {
      case 'active':
        return UserStatus.active;
      case 'inactive':
        return UserStatus.inactive;
      default:
        throw FormatException('Status pengguna tidak valid: $value');
    }
  }
}