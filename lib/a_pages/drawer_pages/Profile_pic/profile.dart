import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_telegram/a_pages/drawer_pages/Profile_pic/edit_profile.dart';
import 'package:flutter_telegram/d_firebase/profile_firebase.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<void> getData() async {}

  editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditProfile(
        name: name,
        userName: username,
        bio: bio,
      ),
    );
  }

  String name = '';
  String username = '';
  String bio = '';

  @override
  void initState() {
    Provider.of<ProfileFirebase>(context, listen: false).fetchImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileFirebase>(builder: (context, profileF, child) {
      return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: ProfileFirebase().getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userdata = snapshot.data!.data() as Map<String, dynamic>;

              name = userdata['Name'];
              username = userdata['UserName'];
              bio = userdata['Bio'];

              return ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * .2,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  profileF.backgroundDownloadableUrl.isEmpty
                                      ? Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.transparent,
                                        )
                                      : CachedNetworkImage(
                                          fadeInCurve: Curves.slowMiddle,
                                          fadeInDuration:
                                              const Duration(microseconds: 0),
                                          imageUrl: profileF
                                              .backgroundDownloadableUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          placeholder: (context, url) =>
                                              Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors
                                                .grey, // Placeholder color while loading
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors
                                                .black, // Background color on error
                                            child: const Icon(Icons.error,
                                                color: Colors.red),
                                          ),
                                        ),
                                  Positioned(
                                    top: 0,
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  editProfile(context);
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              PopupMenuButton(
                                                icon:
                                                    const Icon(Icons.more_vert),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      profileF.pickImage(1);
                                                    },
                                                    child: const Text(
                                                        "background Pic"),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 235, 137, 9),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: profileF.profileDownloadableUrl
                                                  .isEmpty
                                              ? Text(
                                                  name.toString().split("")[0],
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      40,
                                                    ),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: profileF
                                                        .profileDownloadableUrl,
                                                    fadeInCurve:
                                                        Curves.slowMiddle,
                                                    fit: BoxFit.cover,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                  )),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              name,
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                            const Text(
                                              "online",
                                              style: TextStyle(fontSize: 15),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.sizeOf(context).height * .001,
                              color: Colors.black,
                            ),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * .2,
                              color: const Color.fromARGB(255, 14, 26, 32),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Info",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      FirebaseAuth.instance.currentUser!
                                              .phoneNumber ??
                                          "10000000",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Mobile",
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              username,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Text(
                                              "Username",
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.qr_code,
                                              color: Colors.blue,
                                              size: 40,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 150,
                        child: GestureDetector(
                          onTap: () {
                            profileF.pickImage(0);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 141, 206),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .010,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            "Posts",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .1,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            "Archived Posts",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .002,
                    color: Colors.black,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 400,
                    child: const Text(
                      "No Post",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return const Text("Nothing");
            }
          },
        ),
      );
    });
  }
}
