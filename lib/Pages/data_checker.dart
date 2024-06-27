import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/color_file.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: ColorsFile.backGroundGradient),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 200 * Dimensions.standardHieght,
            width: 350 * Dimensions.stw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 40 * Dimensions.standardHieght,
                  width: 80 * Dimensions.stw,
                  margin: EdgeInsets.only(
                      right: 10 * Dimensions.stw,
                      top: 95 * Dimensions.standardHieght),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.577996253967285),
                      gradient: ColorsFile.button1sGradient),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '''Skip''',
                          style: TextStyle(
                            height: 1.35 * Dimensions.sth,
                            fontSize: 18.0 * Dimensions.standardHieght,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 255, 255, 255),

                            /* letterSpacing: 0.0, */
                          ),
                        ),
                        SizedBox(
                          width: 5 * Dimensions.stw,
                        ),
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 18 * Dimensions.standardHieght,
                          //
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )
                      ]),
                ),
              ],
            ),
          ),
          Container(
            height: 250 * Dimensions.standardHieght,
            margin: EdgeInsets.only(top: 50 * Dimensions.standardHieght),
            width: Dimensions.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15 * Dimensions.stw),
                  width: 265 * Dimensions.stw,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: TextStyle(
                        height: .75 * Dimensions.standardHieght,
                        fontSize: 30 * Dimensions.standardHieght,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 25, 15, 15),
                      ),
                      children: [
                        TextSpan(
                          text: '''Hi $myName,
                         Welcome to
                         ''',
                          style: const TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 204, 204, 204),
                          ),
                        ),
                        TextSpan(
                          text: '''VALLEY''',
                          style: TextStyle(
                              fontSize: 30 * Dimensions.standardHieght,
                              color: ColorsFile.purpleColor),
                        ),
                        TextSpan(
                          text: ''' ''',
                          style: TextStyle(
                            fontSize: 30.0 * Dimensions.standardHieght,
                            color: const Color.fromARGB(255, 251, 168, 8),
                          ),
                        ),
                        TextSpan(
                          text: '''MARKET''',
                          style: TextStyle(
                            fontSize: 30.0 * Dimensions.standardHieght,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 15 * Dimensions.standardHieght,
                      left: 15 * Dimensions.stw),
                  width: 265 * Dimensions.stw,
                  child: RichText(
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          height: 1.35 * Dimensions.stw,
                          fontSize: 14.0 * Dimensions.standardHieght,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 255, 255, 255),

                          /* letterSpacing: 0.0, */
                        ),
                        children: [
                          const TextSpan(
                            text: '''Turn on Data services to Allow “''',
                            style: TextStyle(
                              color: Color.fromARGB(255, 239, 251, 249),
                            ),
                          ),
                          TextSpan(
                            text: '''VALLEY MARKET''',
                            style: TextStyle(
                                fontSize: 14.0 * Dimensions.standardHieght,
                                color: ColorsFile.purpleColor

                                /* letterSpacing: null, */
                                ),
                          ),
                          const TextSpan(
                            text:
                                '''” provide access to play games and earn real money''',
                            style: TextStyle(
                              color: Color.fromARGB(255, 239, 251, 249),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.screenWidth,
            height: 190 * Dimensions.standardHieght,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_outlined,
                  size: 100 * Dimensions.standardHieght,
                  color: const Color.fromARGB(255, 155, 155, 155),
                ),
                Container(
                  height: 50 * Dimensions.standardHieght,
                ),
                GestureDetector(
                  onTap: () => Get.to(const HomePage()),
                  child: Container(
                    height: 40 * Dimensions.standardHieght,
                    width: 205 * Dimensions.stw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: ColorsFile.buttonsGradient),
                    child: Center(
                      child: Text(
                        '''Turn on Data''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          height: 1.35 * Dimensions.sth,
                          fontSize: 18.0 * Dimensions.standardHieght,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
