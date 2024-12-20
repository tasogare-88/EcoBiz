import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/auth_error_messages.dart';
import '../../providers/firebase_providers.dart';
import '../domain/auth_user.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  @override
  FutureOr<void> build() {}

  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final auth = ref.read(firebaseAuthProvider);

      // reCAPTCHAの検証をスキップ
      await auth.setSettings(appVerificationDisabledForTesting: true);

      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception(AuthErrorMessages.signUpFailed);
      }

      return AuthUser(
        id: credential.user!.uid,
        email: email,
        displayName: credential.user!.displayName,
        photoURL: credential.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    }
  }

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception(AuthErrorMessages.signInFailed);
      }

      return AuthUser(
        id: credential.user!.uid,
        email: email,
        displayName: credential.user!.displayName,
        photoURL: credential.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    }
  }

  Future<void> signOut() async {
    final auth = ref.read(firebaseAuthProvider);
    await auth.signOut();
  }

  Future<AuthUser> signInWithGoogle() async {
    try {
      final googleSignIn = ref.read(googleSignInProvider);
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception(AuthErrorMessages.googleSignInCanceled);
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final auth = ref.read(firebaseAuthProvider);
      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception(AuthErrorMessages.googleSignInFailed);
      }

      return AuthUser(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        displayName: userCredential.user!.displayName,
        photoURL: userCredential.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    }
  }

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthErrorMessages.invalidEmail;
      case 'user-disabled':
        return AuthErrorMessages.userDisabled;
      case 'user-not-found':
        return AuthErrorMessages.userNotFound;
      case 'wrong-password':
        return AuthErrorMessages.wrongPassword;
      case 'email-already-in-use':
        return AuthErrorMessages.emailAlreadyInUse;
      case 'operation-not-allowed':
        return AuthErrorMessages.operationNotAllowed;
      case 'weak-password':
        return AuthErrorMessages.weakPassword;
      default:
        return AuthErrorMessages.defaultError;
    }
  }
}
