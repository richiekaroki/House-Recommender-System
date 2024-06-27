import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/loading_page.dart';
import 'package:the_tolet/Pages/login_signup_page.dart';

Color changinText1 = Colors.amber;

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _Landing createState() => _Landing();
}

String pageOneString = 'Rent a House \nfor you';
String pagetwoString = 'Find nearest facilities \nfor you';
String pagethreeString = 'Equip a house \nfor you';
String image1 = 'assets/Logo/Image1.png';
String image2 = 'assets/Logo/image2.jpg';
String image3 =
    'assets/Logo/pngtree-modern-house-in-the-woods-picture-image_2673180.jpg';
int counterInt = 0;

class _Landing extends State<Landing> with TickerProviderStateMixin {
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
    return Material(
      child: GestureDetector(
        onTap: () {
          print('tap');
        },
        child: AnimatedContainer(
          width: Dimensions.myWidth,
          height: Dimensions.myHieght,
          color: Color(0xFF000113),
          duration: Duration(seconds: 5),
          curve: Curves.easeInOut,
          child: Page(
            mysetfunction: () {
              setState(() {
                if (counterInt == 0) {
                  counterInt = 1;
                } else {
                  if (counterInt == 1) {
                    counterInt = 2;
                  } else {
                    Get.off(() => const LoginSignUp());
                  }
                }
                print(counterInt);
              });
            },
            title: counterInt == 0
                ? pageOneString
                : counterInt == 1
                    ? pagetwoString
                    : pagethreeString,
            image: counterInt == 0
                ? image1
                : counterInt == 1
                    ? image2
                    : image3,
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    required this.mysetfunction,
    required this.title,
    required this.image,
    Key? key,
  }) : super(key: key);
  final VoidCallback mysetfunction;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.myHieght * .25,
          width: Dimensions.myWidth,
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              height: Dimensions.sth * 1.17,
              fontSize: Dimensions.stw * 34.35,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 255, 255, 255),

              /* letterSpacing: 0.0, */
            ),
          ),
        ),
        Container(
          height: Dimensions.myHieght * .5,
          width: Dimensions.myWidth,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 0)
                ],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              width: Dimensions.myWidth,
              height: Dimensions.myHieght * .5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.standardWidth * 15,
                  ),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.myHieght * .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  '''Reservation Now''',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: Dimensions.sth * 1.17,
                    fontSize: Dimensions.stw * 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 255, 255),

                    /* letterSpacing: 0.0, */
                  ),
                ),
              ),
              Container(
                height: (Dimensions.myHieght * .15) * .15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: Dimensions.myWidth * .16,
                      decoration: BoxDecoration(
                        color: counterInt == 0
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color(0xFFC334155),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(
                        left: Dimensions.myWidth * .16,
                      ),
                    ),
                    Container(
                      width: Dimensions.myWidth * .16,
                      decoration: BoxDecoration(
                        color: counterInt == 1
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color(0xFFC334155),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: Dimensions.myWidth * .16,
                      decoration: BoxDecoration(
                        color: counterInt == 2
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color(0xFFC334155),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(
                        right: Dimensions.myWidth * .16,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: mysetfunction,
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.myWidth * .10,
                    right: Dimensions.myWidth * .10,
                  ),
                  height: (Dimensions.myHieght * .15) * .4,
                  width: Dimensions.myWidth,
                  decoration: BoxDecoration(
                    color: Color(0xFFC334155),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      counterInt == 2 ? 'Sign Up' : 'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: Dimensions.sth * 1.17,
                        fontSize: Dimensions.stw * 25,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 255, 255, 255),

                        /* letterSpacing: 0.0, */
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
