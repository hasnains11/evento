import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;


  Future<String?> authenticateUserWithEmail(String emailAddress,String password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      print(credential);
      return "Login Successful!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
          return 'Wrong password provided for that user.';
      }
    }
  }

  void sendVerificationEmail() async {
    try{
    await user!.sendEmailVerification();
    } catch(e){
        print(e);
    }
  }

  void SignOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> createUserWithEmail(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
  }




}

