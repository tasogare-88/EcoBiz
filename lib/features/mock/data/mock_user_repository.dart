import '../../../core/auth/data/user_repository.dart';
import '../../../core/auth/domain/user.dart';

class MockUserRepository extends UserRepository {
  final Map<String, User> _mockUsers = {
    'mock-user-1': User(
      id: 'mock-user-1',
      name: '山田太郎',
      email: 'yamada@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    'mock-user-2': User(
      id: 'mock-user-2',
      name: '佐藤花子',
      email: 'sato@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    'mock-user-3': User(
      id: 'mock-user-3',
      name: '鈴木一郎',
      email: 'suzuki@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  };

  @override
  Future<User?> getUser(String userId) async {
    return _mockUsers[userId];
  }
}
