import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_telegram/d_firebase/chat_firebase.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatId,
  });

  final String chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ChatFirebase>(
        builder: (context, chatF, child) => Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: chatF.getChatingData(widget.chatId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data?.docs[index];

                        Map<String, dynamic>? chatdataAsMap =
                            doc?.data() as Map<String, dynamic>;

                        return Row(
                          mainAxisAlignment: chatdataAsMap["PhoneNo"] ==
                                  FirebaseAuth.instance.currentUser?.phoneNumber
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Text(
                              chatdataAsMap["Msg"],
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return const Text("");
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              color: Colors.blue,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_emotions_outlined,
                    size: 35,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .7,
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 5, // Set a fixed maxLines value
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                      ),
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        chatF.createChatPage(
                            widget.chatId, textEditingController.text);

                        textEditingController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.telegram_outlined,
                      size: 35,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
