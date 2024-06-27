import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/add_page.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/messages_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/Pages/profile_page.dart';
import 'package:the_tolet/Pages/search_page.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;

class AllPages extends StatefulWidget {
  const AllPages({Key? key}) : super(key: key);

  @override
  _AllPages createState() => _AllPages();
}

int counterInt = 0;

class _AllPages extends State<AllPages> with TickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Scaffold(
        backgroundColor: Color.fromARGB(150, 46, 34, 80),
        bottomNavigationBar: CurvedNavigationBar(
          index: counterInt,
          color: Color.fromARGB(255, 40, 31, 81),
          height: 50 * Dimensions.stw,
          backgroundColor: Color.fromARGB(0, 255, 20, 20),
          items: <Widget>[
            BottomButtons(
              state: pageStatus.home,
              currentState: pageStatus,
              name: 'Home',
              icon: Icons.home,
            ),
            BottomButtons(
              state: pageStatus.search,
              name: 'Events',
              icon: Icons.event,
              currentState: pageStatus,
            ),
            BottomButtons(
              state: pageStatus.records,
              currentState: pageStatus,
              name: 'Add',
              icon: Icons.add_circle_outline,
            ),
            BottomButtons(
              state: pageStatus.messages,
              currentState: pageStatus,
              name: 'Messages',
              icon: Icons.message,
            ),
            BottomButtons(
              state: pageStatus.profile,
              currentState: pageStatus,
              name: 'Profile',
              icon: Icons.person,
            ),
          ],
          onTap: (index) {
            setState(() {
              var mIndex = index;
              if (index == 0) {
                pageState = pageStatus.home;
                setState(() {
                  counterInt = 0;
                });
              } else if (index == 1) {
                pageState = pageStatus.search;
                setState(() {
                  counterInt = 1;
                });
              } else if (index == 2) {
                pageState = pageStatus.records;
                setState(() {
                  counterInt = 2;
                });
              } else if (index == 3) {
                pageState = pageStatus.messages;
                setState(() {
                  counterInt = 3;
                });
              } else if (index == 4) {
                pageState = pageStatus.profile;
                setState(() {
                  counterInt = 4;
                });
              }
            });

            print(pageState);
          },
        ),
        body: counterInt == 0
            ? HomePage()
            : counterInt == 1
                ? SearchPage()
                : counterInt == 2
                    ? AddPage()
                    : counterInt == 3
                        ? MessagePage()
                        : ProfilePage());
  }
}
