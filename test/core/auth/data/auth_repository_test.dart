import 'package:ecobiz/core/auth/data/auth_repository.dart';
import 'package:ecobiz/core/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../lib/shared/constants/auth_error_messages.dart';
@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<User>(),
  MockSpec<UserCredential>(),
  MockSpec<GoogleSignIn>(),
  MockSpec<GoogleSignInAccount>(),
  MockSpec<GoogleSignInAuthentication>(),
])
import 'auth_repository_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late UserCredential mockCredential;
  late User mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockUser = MockUser();
    mockCredential = MockUserCredential();

    when(mockCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('test-id');
    when(mockUser.email).thenReturn('test@example.com');

    container = ProviderContainer(
      overrides: [
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
        googleSignInProvider.overrideWithValue(mockGoogleSignIn),
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
        expect(e, AuthErrorMessages.wrongPassword);
      }
    });

    test('signOut - success', () async {
      final authRepository = container.read(authRepositoryProvider.notifier);

      expect(
        authRepository.signOut(),
        completes,
      );
    });

    test('signInWithGoogle - success', () async {
      final mockGoogleSignInAccount = MockGoogleSignInAccount();
      final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();

      when(mockGoogleSignIn.signIn())
          .thenAnswer((_) async => mockGoogleSignInAccount);
      when(mockGoogleSignInAccount.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(mockGoogleSignInAuthentication.accessToken)
          .thenReturn('mock-access-token');
      when(mockGoogleSignInAuthentication.idToken).thenReturn('mock-id-token');
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenAnswer((_) async => mockCredential);

      final authRepository = container.read(authRepositoryProvider.notifier);
      final result = await authRepository.signInWithGoogle();

      expect(result.id, 'test-id');
      verify(mockGoogleSignIn.signIn()).called(1);
    });
  });
}
