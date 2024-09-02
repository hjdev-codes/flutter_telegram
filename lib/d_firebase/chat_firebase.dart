import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatFirebase extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createChatPage(String chatId, String msg) async {
    final doc = firebaseFirestore
        .collection('UserChats')
        .doc(chatId)
        .collection('Messages');

    // Adding a new message to the 'Messages' sub-collection
    await doc.add({
      'Msg': msg,
      'Time': DateTime.now(),
      'PhoneNo': FirebaseAuth.instance.currentUser?.phoneNumber
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatingData(String chatId) {
    final userCHatData = FirebaseFirestore.instance
        .collection('UserChats')
        .doc(chatId)
        .collection('Messages');

    return userCHatData.orderBy("Time").snapshots();
  }
}
