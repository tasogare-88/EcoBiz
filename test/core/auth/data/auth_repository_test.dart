import 'package:ecobiz/core/auth/data/auth_repository.dart';
import 'package:ecobiz/core/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<User>(),
  MockSpec<UserCredential>(),
])
import 'auth_repository_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockFirebaseAuth mockFirebaseAuth;
  late UserCredential mockCredential;
  late User mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockCredential = MockUserCredential();
    when(mockCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('test-id');
    when(mockUser.email).thenReturn('test@example.com');

    container = ProviderContainer(
      overrides: [
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthRepository', () {
    test('signIn - success', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => mockCredential);

      final authRepository = container.read(authRepositoryProvider.notifier);
      final result = await authRepository.signIn(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result.id, 'test-id');
      expect(result.email, 'test@example.com');
    });

    test('signIn - failure', () async {
      final email = 'test@example.com';
      final password = 'wrongPassword';

      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).thenThrow(FirebaseAuthException(
        code: 'wrong-password',
      ));

      final authRepository = container.read(authRepositoryProvider.notifier);

      try {
        await authRepository.signIn(email: email, password: password);
        fail('Should throw an exception');
      } catch (e) {
        expect(e, 'パスワードが正しくありません');
      }
    });

    test('signOut - success', () async {
      final authRepository = container.read(authRepositoryProvider.notifier);

      expect(
        authRepository.signOut(),
        completes,
      );
    });
  });
}
