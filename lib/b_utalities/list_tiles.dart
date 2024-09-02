import 'package:flutter/material.dart';

class ChatTiles extends StatelessWidget {
  const ChatTiles(
      {super.key,
      this.userName = "Unknown",
      this.messeges = '',
      this.messegeTime = '',
      this.recievedMsg = false,
      this.recievedMsgNumber = "1",
      this.userNameBox = "MM",
      this.userNameBoxColor = Colors.orange,
      this.onTap});

  final String userName;
  final String userNameBox;
  final Color userNameBoxColor;
  final String messeges;

  final String messegeTime;
  final bool recievedMsg;
  final String recievedMsgNumber;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final String newMessegeTime = messegeTime.isEmpty
        ? "${DateTime.now().hour}:${DateTime.now().minute}"
        : messegeTime;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            height: MediaQuery.sizeOf(context).height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: userNameBoxColor),
                        child: Text(
                          userNameBox,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            messeges,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        recievedMsg
                            ? const SizedBox()
                            : messeges.isEmpty
                                ? const SizedBox()
                                : const Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.01,
                        ),
                        Text(
                          newMessegeTime,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    recievedMsg
                        ? Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(recievedMsgNumber),
                          )
                        : const SizedBox(
                            height: 24,
                            width: 24,
                          ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
