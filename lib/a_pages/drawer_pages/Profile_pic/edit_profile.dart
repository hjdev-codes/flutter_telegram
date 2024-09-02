import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_telegram/d_firebase/profile_firebase.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
    required this.name,
    required this.userName,
    required this.bio,
  });

  final String name;
  final String userName;
  final String bio;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);

    TextEditingController userNameController =
        TextEditingController(text: userName);

    TextEditingController bioController = TextEditingController(text: bio);

    return Consumer<ProfileFirebase>(
        builder: (BuildContext context, profileF, Widget? child) {
      return Container(
          color: Theme.of(context).cardColor,
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Profile Info",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      controller: nameController,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      controller: userNameController,
                      onChanged: (value) {
                        profileF.isUserNameIsUsed(value, userName);
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: profileF.userNameUsed
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bio",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    TextField(
                      controller: bioController,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (profileF.userNameUsed == false) {
                          ProfileFirebase().updateProfile(
                              nameController.text,
                              userNameController.text,
                              bioController.text,
                              FirebaseAuth.instance.currentUser!.phoneNumber
                                  .toString());

                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }
}
