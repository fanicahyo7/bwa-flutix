part of 'services.dart';

//untuk segala komunikasi dengan firebase (signup,signin,signout)
class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignUpSignInResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserServices.updateUser(user);

      return SignUpSignInResult(user: user);
    } catch (e) {
      return SignUpSignInResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignUpSignInResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromFirestore();
      return SignUpSignInResult(user: user);
    } catch (e) {
      return SignUpSignInResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignUpSignInResult {
  final User user;
  final String message;

  SignUpSignInResult({this.user, this.message});
}
