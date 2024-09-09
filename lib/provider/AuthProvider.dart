import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Utilisé pour Android et iOS

  User? _user;
  User? get user => _user;

  bool _isSigningIn = false;
  bool get isSigningIn => _isSigningIn;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _isSigningIn = true;
    notifyListeners();

    try {
      if (kIsWeb) {
        // Authentification pour le web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await _auth.signInWithPopup(googleProvider);
      } else {
        // Authentification pour Android et iOS
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          await _auth.signInWithCredential(credential);
        }
      }
    } catch (e) {
      print('Erreur lors de l\'authentification avec Google : $e');
    } finally {
      _isSigningIn = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    if (!kIsWeb) {
      await _googleSignIn.signOut(); // Déconnexion Google sur Android et iOS
    }
    _user = null;
    notifyListeners();
  }

  bool isSignedIn() {
    return _user != null;
  }
}
