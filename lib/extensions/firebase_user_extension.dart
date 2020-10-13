part of 'extensions.dart';

extension FirebaseUserExtention on FirebaseUser {
  User convertToUser(
          {String name = "no name",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      User(this.uid, this.email,
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage,
          balance: balance);

  Future<User> fromFirestore() async => await UserServices.getUser(this.uid);
}
