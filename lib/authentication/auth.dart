import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

User user; // firebase user

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream<User> user; // firebase user
  Stream<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  // constructor
  // AuthService() {
  //   user = Stream(_auth.onAuthStateChanges);

  //   profile = user.switchMap((FirebaseUser u) {
  //     if (u != null) {
  //       return _db
  //           .collection('users')
  //           .document(u.uid)
  //           .snapshots()
  //           .map((snap) => snap.data);
  //     } else {
  //       return Stream.just({});
  //     }
  //   });
  // }

  Future<bool> googleSignIn() async {
    try {
      loading.add(true);
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) return false;

      user = (await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await googleSignInAccount.authentication).idToken,
        accessToken: (await googleSignInAccount.authentication).accessToken,
      )))
          .user;

      if (user == null) return false;

      updateUserData(user);
      debugPrint("User name: ${user.displayName}");

      loading.add(false);
      return true;
    } catch (error) {
      return error;
    }
  }

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'SignOut';
    } catch (e) {
      return e.toString();
    }
  }
}

// TODO refactor global to InheritedWidget
final AuthService authService = AuthService();
