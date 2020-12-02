import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._privateConstructor();
  factory AuthManager() {
    return _instance;
  }
  AuthManager._privateConstructor();

  FirebaseAuth _auth;
  User _user;
  Function _callback;

  void beginListening() {
    _auth = FirebaseAuth.instance;
    print("authmanager begin listening");
    _auth.authStateChanges().listen((User user) {
      _user = user;
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ${user.email}');
        if (_callback != null) {
          _callback();
        } else {
          print("no listener to call");
        }
      }
    });
  }

  void setListener(Function callback) {
    _callback = callback;
  }

  void stopListening() {
    _callback = null;
  }

  Future<UserCredential> createUser(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final existingUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return existingUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void signOut() {
    _auth.signOut();
  }

  String get uid => _user?.uid ?? "";
  String get email => _user?.email ?? "";
  bool get isSignedIn => _user != null;
}
