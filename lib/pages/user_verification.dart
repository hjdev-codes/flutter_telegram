import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_telegram/statemanagement.dart/providerdata.dart';
import 'package:flutter_telegram/utalities/countrycode.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class UserVerification extends StatefulWidget {
  const UserVerification(
      {super.key, required this.onChanged, required this.isDark});

  final bool isDark;

  final Function(bool)? onChanged;

  @override
  State<UserVerification> createState() => _UserVerificationState();
}

class _UserVerificationState extends State<UserVerification> {
  bool switchBool = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.sizeOf(context).width * .04),
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Your Phone",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please confirm your country code \n and enter your phone number.",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(width: .25, color: Colors.black87),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: .25, color: Colors.black87),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PopUpCountryCode(),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(fontSize: 25),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Your phone number",
                              hintStyle: TextStyle(
                                  fontSize: 20, color: Colors.black26),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Sync Contacts",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green,
                        value: switchBool,
                        onChanged: (value) {
                          switchBool = value;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopUpCountryCode extends StatelessWidget {
  const PopUpCountryCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Providerdata>(
        builder: (BuildContext context, value, child) {
      return GestureDetector(
          onTap: () => showPopover(
              direction: PopoverDirection.top,
              context: context,
              bodyBuilder: (context) => const MenusItems(),
              width: 150,
              height: 300),
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: MediaQuery.sizeOf(context).width * .15,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: .25, color: Colors.black87),
              ),
            ),
            child: Text(
              "+${countryCode.keys.toList()[value.seletectedCountry].toString()}",
              style: const TextStyle(fontSize: 25),
            ),
          ));
    });
  }
}

class MenusItems extends StatelessWidget {
  const MenusItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countryCode.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Provider.of<Providerdata>(context, listen: false)
              .selectedCountryNumber(index);

          Navigator.pop(context);
        },
        child: ListTile(
          title: Text(countryCode.values.toList()[index]),
        ),
      ),
    );
  }
}
