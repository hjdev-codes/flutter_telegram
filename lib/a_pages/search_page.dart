import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_telegram/b_utalities/list_tiles.dart';
import 'package:flutter_telegram/d_firebase/search_firebase.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchName = '';

  Stream<QuerySnapshot> searchByName(String name) {
    return FirebaseFirestore.instance
        .collection('userProfile')
        .where('UserName', isEqualTo: name)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchName = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search by Username',
          ),
        ),
      ),
      body: searchName.isEmpty
          ? const Center(child: Text('Enter a username to search'))
          : StreamBuilder<QuerySnapshot>(
              stream: searchByName(searchName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                var data = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var user = data[index];
                    return GestureDetector(
                      onTap: () {
                        ConnectingUsers().idCreation(
                            user["UserNumber"],
                            FirebaseAuth.instance.currentUser!.phoneNumber
                                .toString());

                        ConnectingUsers().createAccount(
                          FirebaseAuth.instance.currentUser!.phoneNumber
                              .toString(),
                          user["UserNumber"],
                        );
                        ConnectingUsers().createAccount(
                            user["UserNumber"],
                            FirebaseAuth.instance.currentUser!.phoneNumber
                                .toString());
                      },
                      child: ChatTiles(
                        userName: user["Name"],
                        userNameBox: user["Name"].toString().split("")[0],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
