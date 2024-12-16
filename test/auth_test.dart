import 'package:notes/services/auth/auth_exceptions.dart';
import 'package:notes/services/auth/auth_provider.dart';
import 'package:notes/services/auth/auth_user.dart';
import 'package:test/test.dart';

// Unit tests for the AuthProvider class
void main() {
  group('Mock Authentication', () {
      final provider = MockAuthProvider();
      test('Should not be initialized to begin with.', () {
        expect(provider.isInitialized, false);
    });

      test('Cannot log out if not initialized', () {
        expect(
          provider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>())
        );
      });
   
    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect (provider.isInitialized, true);
    });
   
    test('User should be null after initialization', () {
        expect (provider.currentUser, null);
      });
   
    test('Should be able to initialize in less than 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    },
     timeout: const Timeout(Duration(seconds: 2)),
   );
    test('Create user should delegate to logIn function', 
    () async {
      final badEmailUser = provider.createUser(
      email: 'lasschuit.bradley@gmail.com',
      password: 'anypassword'
      );
     
      expect(badEmailUser,
             throwsA(const TypeMatcher<UserNotFoundAuthException>()));
     
      final badPasswordUser = provider.createUser(
      email: 'someone@bar.com',
      password: 'jason123',
      );
     
      expect(badPasswordUser,
            throwsA(const TypeMatcher<WrongPassWordAuthException>()));
     
      final user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );
     
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
   
    test('logged in user should be able to get verified', () {
      provider.sendEmailVerification();
        final user = provider.currentUser;
        expect(user, isNotNull);
        expect(user!.isEmailVerified, true);
    });
   
    test('Should be able to logout and login again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
      password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

// logic for the AuthProvider tests
class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'lasschuit.bradley@gmail.com') throw UserNotFoundAuthException();
    if (password == 'jason123') throw InvalidEmailAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    throw UnimplementedError();
  }
}
