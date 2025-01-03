// Login Exceptions
class UserNotFoundAuthException implements Exception {}

class InvalidCredentialAuthException implements Exception {}


//Tutorial one
class WrongPassWordAuthException implements Exception {}

// Register Exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

// Generic Exceptions

class InvalidEmailAuthException implements Exception {}

class GenericAuthAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}