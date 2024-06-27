import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tolet/Pages/all_pagecontroller.dart';
import 'package:the_tolet/Pages/color_file.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';

import '../Dimension.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  _UploadData createState() => _UploadData();
}

class _UploadData extends State<UploadData> {
  DocumentReference<Map<String, dynamic>> thisuser =
      FirebaseFirestore.instance.collection('HouseRentMembers').doc(myUID);

  // Obtain shared preferences.

  Future savePrefferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      testName = myName;
      myFirstname = testName!.split(' ').first;
      mySecondname = testName!.split(' ').elementAt(1);
    });

    await prefs
        .setString('name', myName)
        .whenComplete(() async => await prefs.setString('phone', myPhoneNumber))
        .whenComplete(() async => await prefs.setString('password', myPassword))
        .whenComplete(() async => await prefs.setString('phone', myPhoneNumber))
        .whenComplete(() async => await prefs.setDouble('amount', 0.0))
        .whenComplete(() async => await prefs.setBool('signedUp', true))
        .whenComplete(() => Get.to(const AllPages()));
  }

  Future getPrefferences() async {
    final getPref = await SharedPreferences.getInstance();

    var getName = getPref.getString('name');
    var getPhone = getPref.getString('phone');
    var getPassword = getPref.getString('password');

    setState(() {
      myName = getName.toString();
      testName = getName.toString();
      myPhoneNumber = getPhone.toString();
      myPassword = getPassword.toString();
      myFirstname = testName!.split(' ').first;
      mySecondname = testName!.split(' ').elementAt(1);
    });
    if (kDebugMode) {
      print(myFirstname);
    }
  }

  Future uploadUsersData() {
    print('startingto upload user documents');
    setState(() {
      login = 0;
      isonline = false;
    });
    return thisuser
        .set({
          'full_name': myName, // John Doe

          'Phone': myPhoneNumber, // 42
          'Password': myPassword, // 42
        })
        .timeout(Duration(seconds: 10))
        .then((value) => savePrefferences().whenComplete(() =>
            getPrefferences().whenComplete(() => Get.to(const HomePage()))))
        .catchError((error) {
          setState(() {
            isonline = true;
          });
          print("Failed to add user: $error");
        })
        .whenComplete(() => print('uploaded'));
  }

  bool isonline = false;

  @override
  void initState() {
    uploadUsersData();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width; //to get the width of screen
    MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.000000652319549, -1.0160100320265837),
            end: Alignment(0.999999405736504, 0.9999998213348587),
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
            colors: [
              Color.fromARGB(255, 5, 5, 21),
              Color.fromARGB(255, 6, 15, 46),
              Color.fromARGB(255, 11, 17, 89),
              Color.fromARGB(255, 8, 5, 48),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: Dimensions.screenHieght,
                width: Dimensions.screenHieght,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                        child: SizedBox(
                            height: Dimensions.stw * 50,
                            width: isonline == false
                                ? Dimensions.stw * 50
                                : Dimensions.stw * 150,
                            child: isonline == false
                                ? CircularProgressIndicator(
                                    color: ColorsFile.purpleColor,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadUsersData();
                                    },
                                    child: Container(
                                      width: Dimensions.stw * 100,
                                      height: Dimensions.sth * 30,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(160, 0, 0, 0),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.str * 10)),
                                      child: Center(
                                        child: Text(
                                          'Please Retry',
                                          style: TextStyle(
                                            fontSize: Dimensions.str * 18,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))),
                    Positioned(
                        bottom: Dimensions.sth * 50,
                        left: Dimensions.stw * 70,
                        child: Center(
                          child: Text(
                            isonline == false
                                ? 'Please wait....Uploading...'
                                : "Please Check your data connection",
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: Dimensions.sth * 1.5,
                              fontSize: 18 * Dimensions.str,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: isonline == false
                                  ? ColorsFile.purpleColor
                                  : Color.fromARGB(255, 255, 82, 82),
                            ),
                          ),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
