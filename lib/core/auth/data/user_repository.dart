import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/firebase_providers.dart';
import '../domain/user.dart';

part 'user_repository.g.dart';

@riverpod
class UserRepository extends _$UserRepository {
  @override
  FutureOr<void> build() {}

  Future<User> createUser({
    required String id,
    required String email,
    required String name,
  }) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final now = Timestamp.now();

      final userData = {
        'email': email,
        'name': name,
        'createdAt': now,
        'updatedAt': now,
      };

      await firestore.collection('users').doc(id).set(userData);

      return User(
        id: id,
        email: email,
        name: name,
        createdAt: now.toDate(),
        updatedAt: now.toDate(),
      );
    } catch (e) {
      throw Exception('ユーザーの作成に失敗しました: $e');
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final doc = await firestore.collection('users').doc(userId).get();

      if (!doc.exists) return null;
      return User.fromFirestore(doc);
    } catch (e) {
      throw Exception('ユーザー情報の取得に失敗しました: $e');
    }
  }

  Future<void> updateUserName(String userId, String newName) async {
    try {
      final firestore = ref.read(firestoreProvider);
      await firestore.collection('users').doc(userId).update({
        'name': newName,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('ユーザー名の更新に失敗しました: $e');
    }
  }
}
