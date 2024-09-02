import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_telegram/a_pages/drawer_pages/Profile_pic/profile.dart';
import 'package:flutter_telegram/a_pages/page2/homepage.dart';
import 'package:flutter_telegram/c_statemanagement.dart/providerdata.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      width: MediaQuery.sizeOf(context).width * .85,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
        side: BorderSide(width: 0.01, color: Colors.black),
      ),
      elevation: 0,
      child: ListView(
        children: [
          const TopContainer(),
          RawData(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfile(),
                  ));
            },
            iconData: Icons.account_circle_outlined,
            primaryText: "My Profile",
          ),
          RawData(
            iconData: Icons.account_balance_wallet_outlined,
            primaryText: "Wallet",
            onTap: () {},
          ),
          RawData(
            onTap: () {
              print(add);
              print("Hello");
            },
            iconData: Icons.group_add_outlined,
            primaryText: "New Group",
          ),
          const RawData(
            iconData: Icons.person_outlined,
            primaryText: "Contacts",
          ),
          const RawData(
            iconData: Icons.phone_callback_outlined,
            primaryText: "Calls",
          ),
          const RawData(
            iconData: Icons.near_me_outlined,
            primaryText: "people Nearby",
          ),
          const RawData(
            iconData: Icons.bookmark_outline,
            primaryText: "Saved Messages",
          ),
          RawData(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            iconData: Icons.settings_outlined,
            primaryText: "Settings",
          ),
          const RawData(
            iconData: Icons.person_add_outlined,
            primaryText: "Invite Friends",
          ),
          const RawData(
            iconData: Icons.help_outline,
            primaryText: "Telegram Features",
          ),
        ],
      ),
    );
  }
}

class RawData extends StatelessWidget {
  const RawData(
      {super.key,
      required this.iconData,
      required this.primaryText,
      this.onTap});

  final IconData iconData;

  final String primaryText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: const Color(0xFF7D8D99),
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              primaryText,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).dividerColor),
            )
          ],
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool currentTheme =
        Provider.of<Providerdata>(context, listen: true).DartThemeMode;
    return Container(
      height: MediaQuery.sizeOf(context).height * .25,
      width: MediaQuery.sizeOf(context).width * 1,
      color: Theme.of(context).drawerTheme.scrimColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).drawerTheme.surfaceTintColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 80,
                  width: 80,
                  child: Text(
                    "HJ",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).drawerTheme.backgroundColor),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<Providerdata>(context, listen: false)
                        .newThemecolor(currentTheme ? false : true);
                  },
                  icon: Icon(
                    currentTheme ? Icons.light_mode : Icons.dark_mode,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HJ",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      "+91 7694924672",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Icon(
                  Icons.expand_more,
                  size: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
