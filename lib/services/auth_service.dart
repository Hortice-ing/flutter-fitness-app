import 'package:uuid/uuid.dart';

import '../models/user.dart';
import 'database_service.dart';

class AuthService {
  final db = DatabaseService.instance;

  Future<User?> login(String email, String password) async {
    final database = await db.database;
    final res = await database.query(
      'users',
      where: 'email=? AND password=?',
      whereArgs: [email, password],
    );
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    }
    return null;
  }

  Future<User?> register(String name, String email, String password) async {
    final database = await db.database;
    final id = const Uuid().v4();
    await database.insert('users', {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': DateTime.now().toIso8601String(),
    });
    return User(id: id, name: name, email: email);
  }
}
