import 'package:flutter/foundation.dart' show immutable;
import 'package:notes/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

// EquatableMixin is a utility class that makes it easier to implement the Equatable interface.
// It provides a default implementation of the == operator and the hashCode getter.
// The EquatableMixin class is part of the equatable package.

class AuthStateLoggedOut extends AuthState with EquatableMixin{
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });
  
  @override
  List<Object?> get props => [exception, isLoading];
} 