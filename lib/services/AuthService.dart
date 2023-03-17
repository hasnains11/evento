import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firestore.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;


  Future<void> deleteCurrentUser() async{
      await FirestoreService().deleteCurrentUserFromFirestore();
      await user!.delete();

    }

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

  SignOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> createUserWithEmail(String emailAddress, String password,String name, String gender, int age) async {
    try {
      print(name);
      print(gender);
      print(age);

      // return Future(() => ":asdfasd");
        await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ).then((userCredentials) async =>

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredentials.user?.uid).set({
        'name': name,
        'age': age,
        'gender': gender,
        'email':emailAddress,
      })
       );
        return null;

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

