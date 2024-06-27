import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/Pages/upload_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  _LoginSignUp createState() => _LoginSignUp();
}

class _LoginSignUp extends State<LoginSignUp> with TickerProviderStateMixin {
  String nameLebal = 'Rashid Osman';
  String mpesaLabel = '0748831136';
  String passwordLebel = 'osman1234';

  int nameLebelcolor = 1;
  int phoneLebelcolor = 1;
  int passwordLebelcolor = 1;

  void validateDetails() {
    if (_nameController.text.isNotEmpty) {
      if (_nameController.text.length >= 10) {
        if (_nameController.text.characters.contains(' ')) {
          setState(() {
            nameLebelcolor = 3;
            nameLebal = 'correct';
            myName = _nameController.text;
          });
          if (_phoneController.text.isNotEmpty) {
            if (_phoneController.text.length == 10) {
              setState(() {
                phoneLebelcolor = 3;
                mpesaLabel = 'correct';
                myPhoneNumber = _phoneController.text;
              });
              if (_passwordController.text.isNotEmpty) {
                if (_passwordController.text.length >= 8) {
                  setState(() {
                    passwordLebelcolor = 3;
                    passwordLebel = 'correct';
                    myPassword = _passwordController.text;
                    myUID = myName + myPhoneNumber;
                  });

                  Get.to(const UploadData());
                } else {
                  setState(() {
                    passwordLebelcolor = 2;
                    passwordLebel = 'password is too short';
                  });
                }
              } else {
                setState(() {
                  passwordLebelcolor = 2;
                  passwordLebel = 'Enter Your password';
                });
              }
            } else {
              setState(() {
                phoneLebelcolor = 2;
                mpesaLabel = 'phone format is incorrect';
              });
            }
          } else {
            setState(() {
              phoneLebelcolor = 2;
              mpesaLabel = 'Enter Your Phone';
            });
          }
        } else {
          setState(() {
            nameLebelcolor = 2;
            nameLebal = 'UserName has Two or more names';
          });
        }
      } else {
        setState(() {
          nameLebelcolor = 2;
          nameLebal = 'Your Name is too short';
        });
      }
    } else {
      setState(() {
        nameLebelcolor = 2;
        nameLebal = 'Enter Your Name';
      });
    }
  }

  bool signLoginbool = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Material(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: Dimensions.myWidth,
              height: Dimensions.myHieght,
              color: Color.fromARGB(255, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.myHieght * .33333,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/Logo/pngtree-modern-house-in-the-woods-picture-image_2673180.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: (Dimensions.myHieght * .33333) * .3,
                        width: (Dimensions.myWidth * .75),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/Logo/Logo 1.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: Dimensions.myHieght * .33333,
                    decoration: const BoxDecoration(
                      color: Color(0xFF000113),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            SizedBox(
                              height: (Dimensions.myHieght * .33333) * .15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        signLoginbool = false;
                                      });
                                    }),
                                    child: Container(
                                      height:
                                          (Dimensions.myHieght * .33333) * .15,
                                      width: (Dimensions.myWidth * .25),
                                      decoration: BoxDecoration(
                                          color: signLoginbool == false
                                              ? Color.fromARGB(255, 60, 74, 95)
                                              : Color.fromARGB(0, 51, 65, 85),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 64, 79, 100))),
                                      child: Center(
                                        child: Text(
                                          'Sign Up',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            height: Dimensions.sth * 1.17,
                                            fontSize: Dimensions.stw * 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),

                                            /* letterSpacing: 0.0, */
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        signLoginbool = true;
                                      });
                                    }),
                                    child: Container(
                                      height:
                                          (Dimensions.myHieght * .33333) * .15,
                                      width: (Dimensions.myWidth * .25),
                                      decoration: BoxDecoration(
                                          color: signLoginbool == true
                                              ? Color.fromARGB(255, 60, 74, 95)
                                              : Color.fromARGB(0, 51, 65, 85),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              width: 2,
                                              color: Color(0xFF334155))),
                                      child: Center(
                                        child: Text(
                                          'Log In',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            height: Dimensions.sth * 1.17,
                                            fontSize: Dimensions.stw * 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),

                                            /* letterSpacing: 0.0, */
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              height: signLoginbool == true
                                  ? 90 * Dimensions.standardHieght
                                  : 25 * Dimensions.standardHieght,
                              width: signLoginbool == true
                                  ? 90 * Dimensions.standardWidth
                                  : 20 * Dimensions.standardWidth,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/Logo/Logo 2.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            ),
                            SizedBox(
                              height: Dimensions.sth * 65.5,
                              width: Dimensions.stw * 330,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1 * Dimensions.standardHieght,
                                        fontSize: 12.0,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromARGB(
                                            255, 217, 216, 216),
                                      ),
                                    ),
                                    TextFields(
                                        myController: _phoneController,
                                        textFormFieldFunction: () {},
                                        inputType: TextInputType.number,
                                        myHintStrng: mpesaLabel,
                                        onsubmit: () {
                                          if (kDebugMode) {
                                            print(_phoneController.text);
                                          }
                                        },
                                        colorDecider: phoneLebelcolor),
                                    Container(
                                      height: 1,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            signLoginbool == false
                                ? AnimatedContainer(
                                    height: signLoginbool == false
                                        ? Dimensions.sth * 65.5
                                        : 0,
                                    width: signLoginbool == false
                                        ? Dimensions.stw * 330
                                        : 0,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Username',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              height:
                                                  1 * Dimensions.standardHieght,
                                              fontSize: signLoginbool == false
                                                  ? 12.0
                                                  : 0,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 217, 216, 216),
                                            ),
                                          ),
                                          TextFields(
                                              myController: _nameController,
                                              textFormFieldFunction: () {},
                                              inputType: TextInputType.name,
                                              myHintStrng: nameLebal,
                                              onsubmit: () {
                                                if (kDebugMode) {
                                                  print(_phoneController.text);
                                                }
                                              },
                                              colorDecider: nameLebelcolor),
                                          Container(
                                            height:
                                                signLoginbool == false ? 1 : 0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            SizedBox(
                              height: Dimensions.sth * 65.5,
                              width: Dimensions.stw * 330,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      width: signLoginbool == false
                                          ? Dimensions.myWidth * .90
                                          : Dimensions.myWidth * .65,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Password',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                height: 1 *
                                                    Dimensions.standardHieght,
                                                fontSize: 12.0,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromARGB(
                                                    255, 217, 216, 216),
                                              ),
                                            ),
                                            TextFields(
                                                myController:
                                                    _passwordController,
                                                textFormFieldFunction: () {},
                                                inputType: TextInputType.name,
                                                myHintStrng: passwordLebel,
                                                onsubmit: () {
                                                  if (kDebugMode) {
                                                    print(
                                                        _phoneController.text);
                                                  }
                                                },
                                                colorDecider:
                                                    passwordLebelcolor),
                                            Container(
                                              height: 1,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    signLoginbool == true
                                        ? Container(
                                            width: Dimensions.myWidth * .25,
                                            child: Text(
                                              'Forgot?',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                height: 1 *
                                                    Dimensions.standardHieght,
                                                fontSize: 20.0,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromARGB(
                                                    255, 217, 216, 216),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: Dimensions.myHieght * .33333,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (() {
                            if (kDebugMode) {
                              print('running');
                            }
                            validateDetails();
                          }),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30 * Dimensions.standardWidth,
                                right: 30 * Dimensions.standardWidth),
                            decoration: BoxDecoration(
                                color: Color(0xFF334155),
                                borderRadius: BorderRadius.circular(10)),
                            height: (Dimensions.myHieght * .33333) * .20,
                            child: Center(
                              child: Text(
                                signLoginbool == false
                                    ? 'Sign Up Now'
                                    : 'Log In Now',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: (Dimensions.myHieght * .33333) * .25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Or continue with',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (Dimensions.myHieght * .33333) * .25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Color(0xFF334155)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    width: Dimensions.myWidth * .35,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Logo/google.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Color(0xFF334155)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    width: Dimensions.myWidth * .35,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Logo/Facebook.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: (Dimensions.myHieght * .33333) * .25,
                          child: Center(
                            child: Text(
                              'Powered by ProRent Company',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: const Color.fromARGB(255, 255, 255, 255),

                                /* letterSpacing: 0.0, */
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
