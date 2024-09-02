import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_telegram/a_pages/chat.dart';
import 'package:flutter_telegram/a_pages/drawer_pages/drawer_page.dart';
import 'package:flutter_telegram/a_pages/search_page.dart';
import 'package:flutter_telegram/b_utalities/list_tiles.dart';
import 'package:flutter_telegram/d_firebase/chat_firebase.dart';
import 'package:flutter_telegram/d_firebase/profile_firebase.dart';
import 'package:flutter_telegram/d_firebase/search_firebase.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    ProfileFirebase().currentProfile();
    ConnectingUsers().createFirstListFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseDB().currentProfile();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawerScrimColor: Theme.of(context).indicatorColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text("Telegram"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const DrawerView(),
      body: StreamBuilder(
        stream: ConnectingUsers().getfriendList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List friends = snapshot.data!['Friends'];

            return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                  stream: ConnectingUsers().getFrienddata(friends[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var collectionReference = snapshot.data;

                      String name = collectionReference!["Name"];
                      String friendNumber = collectionReference["UserNumber"];

                      String myNumber = FirebaseAuth
                          .instance.currentUser!.phoneNumber
                          .toString();

                      String chatid =
                          ConnectingUsers().idCreation(friendNumber, myNumber);

                      return StreamBuilder(
                        stream: ChatFirebase().getChatingData(chatid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final qs = snapshot.data?.docs.last;

                            Map<String, dynamic> mp =
                                qs?.data() as Map<String, dynamic>;

                            //  String time = mp["Time"].toString();

                            Timestamp time = mp["Time"];

                            DateTime datetime = time.toDate();

                            String msgTime =
                                "${datetime.hour}:${datetime.minute}";

                            print(datetime.hour);

                            return ChatTiles(
                              messegeTime: msgTime,
                              userName: name,
                              userNameBox: name[0],
                              messeges: mp["Msg"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatScreen(chatId: chatid),
                                    ));
                              },
                            );
                          }

                          return const ChatTiles();
                        },
                      );
                    }

                    return const Text("data");
                  },
                );
              },
            );
          }
          return const Text("Song");
        },
      ),
    );
  }
}

const user1Id = '22';
const user2Id = '11';

final add = [user1Id, user2Id]
  ..sort()
  ..join('_');
