import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnectingUsers {
  String idCreation(String phoneNumber1, String phoneNumber2) {
    String user1Id = phoneNumber1;
    String user2Id = phoneNumber2;

    final add = [user1Id, user2Id]..sort();
    String id = "${add[0]}${add[1]}";
    return id;
    // print(id);
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createFirstListFriend() async {
    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection("FriendList")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .get();

    if (!documentSnapshot.exists) {
      firebaseFirestore
          .collection("FriendList")
          .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
          .set({"Friends": []});
    }
  }

  Future<void> createAccount(
    String myNumber,
    String otherNumber,
  ) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection("FriendList").doc(myNumber).get();

    if (!documentSnapshot.exists) {
      firebaseFirestore.collection("FriendList").doc(myNumber).set({
        "Friends": [otherNumber]
      });
    } else {
      firebaseFirestore.collection("FriendList").doc(myNumber).update({
        "Friends": FieldValue.arrayUnion([otherNumber])
      });
    }
  }

  Stream<DocumentSnapshot> getfriendList() {
    final snapshot = firebaseFirestore
        .collection("FriendList")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .snapshots();
    //print(snapshot);
    return snapshot;
  }

  Stream<DocumentSnapshot> getFrienddata(String users) {
    final snapshots =
        firebaseFirestore.collection("userProfile").doc(users).snapshots();

    return snapshots;
  }
}
