import 'auth_functions.dart';

AuthResponse handleFirebaseError(String error) {
  print('ERROR auth: $error');
  if (error.contains('FirebaseError')) {
    var err = error.substring(15);
    return AuthResponse(message: err, success: false);
  }
  return AuthResponse(message: error, success: false);
}
