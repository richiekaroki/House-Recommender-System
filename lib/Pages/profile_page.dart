import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/messages_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

String pageOneString = 'Rent a House \nfor you';
String pagetwoString = 'Find nearest facilities \nfor you';
String pagethreeString = 'Equip a house \nfor you';
String image1 = 'assets/Logo/Image1.png';
String image2 = 'assets/Logo/image2.jpg';
String image3 =
    'assets/Logo/pngtree-modern-house-in-the-woods-picture-image_2673180.jpg';
int counterInt = 0;

class _ProfilePage extends State<ProfilePage> with TickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    pageState = pageStatus.profile;
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Container(
        color: Color(0xFF2E2250),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/black-boy-posing_23-2148171526.jpg?w=740&t=st=1700312023~exp=1700312623~hmac=f8f39d443be066c697aba88e49e01cf91d5847321422e19d106eba5f6f11d2bd')),
              SizedBox(height: 20.0),
              Text(
                myName,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Software Developer',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Bio:',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Passionate software developer with a focus on mobile app development. '
                'Experienced in Flutter and Dart.',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact:',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Email: john.doe@example.com\n'
                'Phone:  $myPhoneNumber',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                'Social Media:',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.link,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      // Open the link to the Twitter profile
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.link,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      // Open the link to the LinkedIn profile
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.link,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      // Open the link to the GitHub profile
                    },
                  ),
                ],
              ),
              SizedBox(height: 100.0),
              SizedBox(
                width: Dimensions.myWidth,
                child: GestureDetector(
                  onTap: () {
                    //  dataChecker();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 50 * Dimensions.sth,
                    width: Dimensions.myWidth * .5,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Log Out',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          height: Dimensions.sth * 1.17,
                          fontSize: Dimensions.stw * 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 255, 255, 255),

                          /* letterSpacing: 0.0, */
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
