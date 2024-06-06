import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelli_chat/common_utilities/get_storage_utility/get_storage_functions.dart';
import 'package:intelli_chat/common_utilities/helper_functions.dart';
import 'package:intelli_chat/constants/constants.dart';


class FirebaseHelper
{
    Future<bool> addUserToFireStore(String email, String name, String password, String userId)
    async {
    DocumentReference users = FirebaseFirestore.instance.collection('users').doc(userId);
    try
    {
      users.set({Constants.email : email, Constants.name : name, Constants.password : password});
      /// Store UserID in memory
      StorageService().saveData(Constants.userId, userId);
      return true;
    }
    catch(e)
    {
        log("\n Failed to add User");
    }
    return false;
    }

    Future<bool> createUser(String email, String name ,String password)
    async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        StaticConstants.userId = userCredential.user!.uid;
        HelperFunctions().setUser(name, email, StaticConstants.userId);
        print("User registered successfully: ${userCredential.user?.uid}");
        return await addUserToFireStore(email , name, password, userCredential.user!.uid);
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password')
        {
          print('The password provided is too weak.');
        }
        else if (e.code == 'email-already-in-use')
        {
          print('The account already exists for that email.');
        }
        else
        {
          print('An error occurred: ${e.message}');
        }
      }
      catch (e) {
        print('An error occurred: $e');
      }
      return false;
    }

    Future<bool> login(String email, String password)
    async {
      try {
        print("wait");
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        StaticConstants.userId = credential.user!.uid;
        StorageService().saveData(Constants.userId , StaticConstants.userId);
        await fetchUser(StaticConstants.userId);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      catch(e)
      {
        print("Error occurred" + e.toString());
      }
      return false;
    }

    Future<bool> fetchUser(String userId) async{
      try
      {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(StaticConstants.userId).get();
        HelperFunctions().setUser(snapshot[Constants.name], snapshot[Constants.email], userId);
      }
      catch(e)
      {
        print("Error !" + e.toString());
      }
      return true;
    }

}
