import 'dart:io';
import 'package:flutter/material.dart';
import 'package:the_tolet/Pages/personal_data.dart';

import 'Dimension.dart';

class BottomButtons extends StatelessWidget {
  BottomButtons({
    Key? key,
    required this.state,
    required this.name,
    required this.icon,
    required this.currentState,
  }) : super(key: key);

  final String name;
  final IconData icon;
  var state;
  var currentState;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.standardHieght * 50,
      width: Dimensions.standardWidth * 50,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: pageState == state ? Colors.amber : Colors.white,
          ),
          Text(
            name,
            style: TextStyle(
                color: pageState == state ? Colors.amber : Colors.white,
                fontSize: Dimensions.standardWidth * 8),
          ),
        ],
      ),
    );
  }
}

class IndicatorIcons extends StatelessWidget {
  IndicatorIcons({
    Key? key,
    required this.indexx,
    required this.currentindexx,
  }) : super(key: key);

  final int indexx;
  final int currentindexx;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: indexx == currentindexx
            ? Colors.amber
            : Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}

class AnchorButtons extends StatelessWidget {
  AnchorButtons({
    Key? key,
    required this.state,
    required this.name,
    required this.mycolor,
  }) : super(key: key);

  final String name;
  final Color mycolor;
  var state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: (Dimensions.myHieght * .3333333) * .17,
      width: Dimensions.myWidth * .25,
      decoration: BoxDecoration(
          color:
              anchorState == state ? mycolor : Color.fromARGB(214, 55, 58, 97),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.left,
          style: TextStyle(
            height: Dimensions.sth * 1.17,
            fontSize: Dimensions.stw * 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: anchorState == state
                ? Color.fromARGB(255, 255, 255, 255)
                : mycolor,

            /* letterSpacing: 0.0, */
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController myController;
  final VoidCallback textFormFieldFunction;

  final TextInputType inputType;
  final String myHintStrng;
  final int colorDecider;
  final VoidCallback onsubmit;

  const TextFields({
    Key? key,
    required this.myController,
    required this.onsubmit,
    required this.textFormFieldFunction,
    required this.inputType,
    required this.myHintStrng,
    required this.colorDecider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.words,
      keyboardType: inputType,
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 182, 219, 162),
      ),
      controller: myController,
      decoration: InputDecoration(
        labelText: myHintStrng,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorDecider == 1
              ? Color.fromARGB(255, 103, 131, 171)
              : colorDecider == 3
                  ? const Color.fromARGB(255, 127, 255, 80)
                  : const Color.fromARGB(255, 243, 121, 33),
        ),
      ),
    );
  }
}

class TextFields1 extends StatelessWidget {
  final TextEditingController myController;
  final VoidCallback textFormFieldFunction;

  final TextInputType inputType;
  final String myHintStrng;
  final int colorDecider;
  final VoidCallback onsubmit;
  final IconData myicon;

  const TextFields1({
    Key? key,
    required this.myController,
    required this.onsubmit,
    required this.textFormFieldFunction,
    required this.inputType,
    required this.myHintStrng,
    required this.colorDecider,
    required this.myicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.words,
      keyboardType: inputType,
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 182, 219, 162),
      ),
      controller: myController,
      decoration: InputDecoration(
        icon: Icon(
          myicon,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        labelText: myHintStrng,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorDecider == 1
              ? Color.fromARGB(255, 255, 216, 76)
              : colorDecider == 3
                  ? const Color.fromARGB(255, 127, 255, 80)
                  : const Color.fromARGB(255, 243, 121, 33),
        ),
      ),
    );
  }
}

class MyText1 extends StatelessWidget {
  final String mytextStrng;

  const MyText1({
    Key? key,
    required this.mytextStrng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      mytextStrng,
      textAlign: TextAlign.left,
      style: TextStyle(
        height: 1 * Dimensions.standardHieght,
        fontSize: 12.0 * Dimensions.str,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: const Color.fromARGB(255, 217, 216, 216),
      ),
    );
  }
}

class SelectionWidget extends StatelessWidget {
  final String mytextStrng;
  final VoidCallback callback;
  var state;

  SelectionWidget({
    Key? key,
    required this.mytextStrng,
    required this.callback,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30 * Dimensions.sth,
          width: Dimensions.myWidth * .25,
          decoration: BoxDecoration(
              color: selectedstate == state
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1, color: Color.fromRGBO(255, 255, 255, 1))),
          child: Center(
            child: Text(
              mytextStrng,
              textAlign: TextAlign.left,
              style: TextStyle(
                height: Dimensions.sth * 1.17,
                fontSize: Dimensions.stw * 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: selectedstate == state
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(255, 255, 255, 255),

                /* letterSpacing: 0.0, */
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionWidget1 extends StatelessWidget {
  final String mytextStrng;
  final VoidCallback callback;
  final bool state;

  SelectionWidget1({
    Key? key,
    required this.mytextStrng,
    required this.callback,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30 * Dimensions.sth,
          width: Dimensions.myWidth * .25,
          decoration: BoxDecoration(
              color: state == true
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1, color: Color.fromRGBO(255, 255, 255, 1))),
          child: Center(
            child: Text(
              mytextStrng,
              textAlign: TextAlign.left,
              style: TextStyle(
                height: Dimensions.sth * 1.17,
                fontSize: Dimensions.stw * 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: state == true
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(255, 255, 255, 255),

                /* letterSpacing: 0.0, */
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtherImageWidget extends StatelessWidget {
  final List<File> imageFiless;

  final int index;
  final int decider;

  OtherImageWidget({
    Key? key,
    required this.imageFiless,
    required this.index,
    required this.decider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      clipBehavior: Clip.hardEdge,
      height: Dimensions.myWidth * .25,
      width: Dimensions.myWidth * .25,
      decoration: BoxDecoration(
          color: Color.fromARGB(61, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: Colors.white,
          )),
      child: Center(
        child: decider == 0
            ? Text(
                (index + 1).toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: Dimensions.sth * 1.17,
                  fontSize: Dimensions.stw * 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255),

                  /* letterSpacing: 0.0, */
                ),
              )
            : SizedBox(
                height: Dimensions.myWidth * .45,
                width: Dimensions.myWidth * .45,
                child: Image.file(
                  imageFiless.elementAt(index),
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }
}

class HouseDisplay1 extends StatelessWidget {
  final VoidCallback myFunction;
  final String networkImage;
  final String propertyType;
  final String propertyPrize;

  HouseDisplay1({
    Key? key,
    required this.myFunction,
    required this.networkImage,
    required this.propertyType,
    required this.propertyPrize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 100,
      height: (Dimensions.myHieght * .3333333) * .8,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 48, 54, 90),
          borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: myFunction,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(networkImage)),
                ),
                height: (Dimensions.myHieght * .3333333) * .55,
              ),
              Container(
                height: (Dimensions.myHieght * .3333333) * .20,
                child: Column(
                  children: [
                    SizedBox(
                      height: ((Dimensions.myHieght * .3333333) * .20) * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            propertyType,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                          Text(
                            propertyPrize,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 98, 92, 255),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ((Dimensions.myHieght * .3333333) * .20) * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '200SQFT',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 133, 210, 50),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                          Text(
                            '2 Lounge   1 Kitchen',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 184, 92),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HouseDisplay2 extends StatelessWidget {
  final VoidCallback myFunction;
  final String networkImage;
  final String propertyName;
  final String propertyPrize;
  final String propertyLocation;

  HouseDisplay2({
    Key? key,
    required this.myFunction,
    required this.networkImage,
    required this.propertyName,
    required this.propertyPrize,
    required this.propertyLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: myFunction,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 20),
        height: 90,
        width: Dimensions.myWidth,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 48, 54, 90),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(networkImage)),
                ),
              ),
              SizedBox(
                width: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ((Dimensions.myHieght * .3333333) * .20) * .5,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '$propertyName    ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255),

                                /* letterSpacing: 0.0, */
                              ),
                            ),
                            Text(
                              propertyPrize,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 98, 92, 255),

                                /* letterSpacing: 0.0, */
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          Text(
                            propertyLocation,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ((Dimensions.myHieght * .3333333) * .20) * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '200SQFT',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 133, 210, 50),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                          Text(
                            '2 Lounge   1 Kitchen',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 184, 92),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchDisplay extends StatelessWidget {
  final VoidCallback myFunction;
  final String networkImage;
  final String propertyName;
  final String propertyPrize;
  final String propertyLocation;

  SearchDisplay({
    Key? key,
    required this.myFunction,
    required this.networkImage,
    required this.propertyName,
    required this.propertyPrize,
    required this.propertyLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: myFunction,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 20),
        height: 100 * Dimensions.sth,
        width: Dimensions.myWidth,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 48, 54, 90),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(networkImage)),
                ),
              ),
              SizedBox(
                width: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ((Dimensions.myHieght * .3333333) * .20) * .5,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '$propertyName  ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255),

                                /* letterSpacing: 0.0, */
                              ),
                            ),
                            Text(
                              propertyPrize,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 98, 92, 255),

                                /* letterSpacing: 0.0, */
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          Text(
                            propertyLocation,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ((Dimensions.myHieght * .3333333) * .20) * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '200SQFT',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 133, 210, 50),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                          Text(
                            '2 Lounge   1 Kitchen',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: Dimensions.sth * 1.17,
                              fontSize: Dimensions.stw * 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 184, 92),

                              /* letterSpacing: 0.0, */
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
