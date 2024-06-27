import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tolet/Pages/all_pagecontroller.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/landing_page.dart';
import 'package:the_tolet/Pages/login_signup_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';

import '../Dimension.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  bool? checkBool;
  // Obtain shared preferences.
  Future getPrefferences() async {
    if (kDebugMode) {
      print('getting');
    }

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

  Future getBool() async {
    final getPref = await SharedPreferences.getInstance();

    var getCheckBool = getPref.getBool('signedUp');

    setState(() {
      checkBool = getCheckBool;
    });
    if (kDebugMode) {
      print(checkBool);
    }
  }

  Future deletePrefferences() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove('Records');
    if (kDebugMode) {
      print('is home key deleted');
    }
  }

  @override
  void initState() {
    login = 1;
    setState(() {
      print('My Log In ' + login.toString());
    });
    getBool().whenComplete(() async {
      if (kDebugMode) {
        print(checkBool);
      }
      if (checkBool == null) {
      } else {
        deletePrefferences();
        getPrefferences();
      }
      Timer(
        const Duration(seconds: 3),
        () => checkBool == null
            ? Get.off(() => const Landing())
            : Get.off(() => const AllPages()),
      );
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;

    return Material(
      color: Colors.black,
      child: Container(
        height: Dimensions.myHieght,
        width: Dimensions.myWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Logo/SplashBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 16 * Dimensions.sth,
            ),
            Container(
              height: 150 * Dimensions.stw,
              width: 150 * Dimensions.stw,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Logo/Logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              child: Center(
                child: checkBool == null
                    ? Text(
                        'Please wait....loading...',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5 * Dimensions.sth,
                            fontSize: 16 * Dimensions.sth,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple),
                      )
                    : Text(
                        'Welcome back   $myName',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5 * Dimensions.sth,
                            fontSize: 16 * Dimensions.sth,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(141, 255, 255, 255)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
