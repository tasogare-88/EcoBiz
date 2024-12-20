import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/core/auth/data/user_repository.dart';
import '../../../../lib/core/providers/firebase_providers.dart';

void main() {
  late ProviderContainer container;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    container = ProviderContainer(
      overrides: [
        firestoreProvider.overrideWithValue(fakeFirestore),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('UserRepository', () {
    test('ユーザーを作成して取得できる', () async {
      final repository = container.read(userRepositoryProvider.notifier);

      final user = await repository.createUser(
        id: 'test-id',
        email: 'test@example.com',
        name: 'テストユーザー',
      );

      expect(user.id, 'test-id');
      expect(user.email, 'test@example.com');
      expect(user.name, 'テストユーザー');

      final fetchedUser = await repository.getUser('test-id');
      expect(fetchedUser?.name, 'テストユーザー');
    });

    test('存在しないユーザーの場合はnullを返す', () async {
      final repository = container.read(userRepositoryProvider.notifier);
      final user = await repository.getUser('non-existent-id');
      expect(user, isNull);
    });

    test('ユーザー名を更新できる', () async {
      final repository = container.read(userRepositoryProvider.notifier);

      await repository.createUser(
        id: 'test-id',
        email: 'test@example.com',
        name: 'テストユーザー',
      );

      await repository.updateUserName('test-id', '新しい名前');

      final updatedUser = await repository.getUser('test-id');
      expect(updatedUser?.name, '新しい名前');
    });
  });
}
