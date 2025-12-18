import '../models/user.dart';
import 'database_service.dart';

class AuthService {

  Future<bool> register(User user) async {
    final db = await DatabaseService.database;
    try {
      await db.insert('users', user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final db = await DatabaseService.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }
}
