import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/messages_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

String pageOneString = 'Rent a House \nfor you';
String pagetwoString = 'Find nearest facilities \nfor you';
String pagethreeString = 'Equip a house \nfor you';
String image1 = 'assets/Logo/Image1.png';
String image2 = 'assets/Logo/image2.jpg';
String image3 =
    'assets/Logo/pngtree-modern-house-in-the-woods-picture-image_2673180.jpg';
int counterInt = 0;

class _SearchPage extends State<SearchPage> with TickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    pageState = pageStatus.search;
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Container(
      color: Color(0xFF2E2250),
    );
  }
}
