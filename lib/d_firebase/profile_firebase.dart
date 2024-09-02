import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFirebase extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userProfileCollection =
      FirebaseFirestore.instance.collection("userProfile");

  String profileDownloadableUrl = '';
  String backgroundDownloadableUrl = '';
  bool userNameUsed = false;

  Future<void> currentProfile() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final doc = await _userProfileCollection.doc(currentUser.phoneNumber).get();
    if (!doc.exists) {
      await _userProfileCollection.doc(currentUser.phoneNumber).set({
        "Name": "Unknown",
        "UserName": "Unknown",
        "Bio": "empty bio",
        "UserNumber": currentUser.phoneNumber,
      });
    }
  }

  Stream<DocumentSnapshot<Object?>> getProfileData() {
    final currentUser = _auth.currentUser;
    return _userProfileCollection.doc(currentUser?.phoneNumber).snapshots();
  }

  Future<void> updateProfile(
      String name, String userName, String bio, String myNumber) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    await _userProfileCollection.doc(currentUser.phoneNumber).update({
      "Name": name,
      "UserName": userName,
      "Bio": bio,
      "UserNumber": myNumber,
    });
  }

  Future<void> uploadImage(File imageFile, int type) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final pathType = type == 0 ? "ProfilePic" : "backgroundPic";
    final filePath =
        'My_images/${currentUser.phoneNumber}/$pathType/${DateTime.now()}.png';

    try {
      await FirebaseStorage.instance.ref(filePath).putFile(imageFile);
      await fetchImages();
      notifyListeners();
    } catch (e) {
      if (e is FirebaseException) {
        print('FirebaseException: ${e.code} - ${e.message}');
      } else {
        print(e);
      }
    }
  }

  Future<void> pickImage(int type) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      await uploadImage(File(pickedImage.path), type);
    } else {
      print("Image picking cancelled by the user");
    }
  }

  Future<void> deleteAllImageExceptLast(List<Reference> imageReferences) async {
    for (var i = 0; i < imageReferences.length - 1; i++) {
      try {
        await imageReferences[i].delete();
      } catch (e) {
        print("Failed to delete image: $e");
      }
    }
  }

  Future<void> deleteLastPic() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final result = await FirebaseStorage.instance
        .ref('My_images/${currentUser.phoneNumber}/backgroundPic/')
        .listAll();

    if (result.items.isNotEmpty) {
      await result.items.last.delete();
    }
  }

  Future<void> fetchImages() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      final profilePath = 'My_images/${currentUser.phoneNumber}/ProfilePic/';
      final backgroundPath =
          'My_images/${currentUser.phoneNumber}/backgroundPic/';

      final profileResult =
          await FirebaseStorage.instance.ref(profilePath).listAll();
      final backgroundResult =
          await FirebaseStorage.instance.ref(backgroundPath).listAll();

      profileDownloadableUrl = profileResult.items.isNotEmpty
          ? await profileResult.items.last.getDownloadURL()
          : '';

      backgroundDownloadableUrl = backgroundResult.items.isNotEmpty
          ? await backgroundResult.items.last.getDownloadURL()
          : '';

      await deleteAllImageExceptLast(profileResult.items);
      await deleteAllImageExceptLast(backgroundResult.items);

      gotTheImageUrl();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> isUserNameIsUsed(String userName, String presentUserName) async {
    final CollectionReference userProfileName =
        FirebaseFirestore.instance.collection("userProfile");

    QuerySnapshot querySnapshot =
        await userProfileName.where('UserName', isEqualTo: userName).get();

    if (querySnapshot.docs.isNotEmpty && userName != presentUserName) {
      userNameUsed = true;
    } else if (querySnapshot.docs.isEmpty) {
      userNameUsed = false;
    }
    notifyListeners();
  }

  bool notGotThePageData = true;
  Future gotTheImageUrl() async {
    while (
        profileDownloadableUrl.isEmpty && backgroundDownloadableUrl.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    await Future.delayed(
      const Duration(seconds: 2),
    );

    print("done");
    notGotThePageData = false;

    notifyListeners();
  }
}
