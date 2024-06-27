import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/loading_page.dart';
import 'package:the_tolet/Pages/login_signup_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;

class ContentsPage extends StatefulWidget {
  const ContentsPage({Key? key}) : super(key: key);

  @override
  _ContentsPage createState() => _ContentsPage();
}

List<Widget> indicator = [];

List<String> otherimageList = [
  'https://img.freepik.com/free-photo/3d-rendering-modern-dining-room-living-room-with-luxury-decor_105762-2000.jpg?w=1380&t=st=1700562700~exp=1700563300~hmac=fd6b10491a6fe077b98f28aac835bf0d270c435ce7c3fa2e76e7fb2cc28989d0',
  'https://img.freepik.com/premium-psd/poster-frame-living-room-mockup_1150-51582.jpg?w=996',
  'https://img.freepik.com/premium-photo/3d-rendering-luxury-modern-living-room-with-chandelier_105762-1228.jpg?w=1060',
  'https://img.freepik.com/free-photo/modern-dining-room-living-room-with-luxury-decor_105762-1672.jpg?w=826&t=st=1700562785~exp=1700563385~hmac=4db294caf2ee695eefd06523b2fb84f64304841a879140e8b17b0a40aa616956',
  'https://img.freepik.com/premium-photo/luxurious-fashionable-living-room-with-soft-sofa-armchair-tv-unit-console-with-decor-beautiful-floor-lamp-interior-mint-colors-3d-rendering_295714-5060.jpg?w=900',
  'https://img.freepik.com/premium-photo/meeting-room-with-large-table-yellow-armchairs-glass-wall-3d-render_295714-6204.jpg?w=900',
  '',
];

String pageOneString = 'Rent a House \nfor you';
String pagetwoString = 'Find nearest facilities \nfor you';
String pagethreeString = 'Equip a house \nfor you';
String image1 = 'assets/Logo/Image1.png';
String image2 = 'assets/Logo/image2.jpg';
String image3 =
    'assets/Logo/pngtree-modern-house-in-the-woods-picture-image_2673180.jpg';
int indicatorInt = 0;

class _ContentsPage extends State<ContentsPage> with TickerProviderStateMixin {
  @override
  void initState() {
    CreateAmentiyList();
    super.initState();
  }

  final pageViewController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  List<Widget> myAmenityWidgets = [];

  void CreateAmentiyList() {
    amenitiesToShow.forEach((element) {
      myAmenityWidgets.add(
        Container(
          width: Dimensions.myWidth * .2,
          child: Column(
            children: [
              const Icon(
                Icons.bed,
                size: 20,
                color: Colors.amber,
              ),
              Text(
                element,
                textAlign: TextAlign.left,
                style: TextStyle(
                    height: Dimensions.sth * 1.17,
                    fontSize: Dimensions.stw * 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 55, 55, 55)

                    /* letterSpacing: 0.0, */
                    ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    indicator = [];
    otherimageList.forEach((element) {
      indicator.add(IndicatorIcons(
        indexx: otherimageList.indexOf(element),
        currentindexx: indicatorInt,
      ));
    });

    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Scaffold(
      body: Material(
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
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.myHieght * .35,
                  width: Dimensions.myWidth,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: Dimensions.myHieght * .35,
                          width: Dimensions.myWidth,
                          child: PageView.builder(
                            onPageChanged: (page) {
                              setState(() {
                                indicatorInt = page;
                                print(indicatorInt);
                              });
                            },
                            scrollDirection: Axis.horizontal,
                            allowImplicitScrolling: true,
                            padEnds: false,
                            controller: pageViewController,
                            itemCount: otherimageList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: Dimensions.myHieght * .35,
                                width: Dimensions.myWidth,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(index == 0
                                            ? imagetoshow
                                            : otherimageList
                                                .elementAt(index - 1)))),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: Dimensions.myHieght * .35,
                          width: Dimensions.myWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    ((Dimensions.myHieght * .25) * .25) * .5,
                                width: Dimensions.myWidth * .2,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'FOR SALE',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        height: Dimensions.sth * 1.17,
                                        fontSize: Dimensions.stw * 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)

                                        /* letterSpacing: 0.0, */
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                height:
                                    ((Dimensions.myHieght * .25) * .25) * .6,
                                child: Text(
                                  'Big House',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 255, 255)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ),
                              Container(
                                height: ((Dimensions.myHieght * .25) * .25) *
                                    .33333,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Nairobi',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          height: Dimensions.sth * 1.17,
                                          fontSize: Dimensions.stw * 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          color:
                                              Color.fromARGB(255, 255, 255, 255)

                                          /* letterSpacing: 0.0, */
                                          ),
                                    ),
                                    Icon(
                                      Icons.area_chart,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '520m2',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          height: Dimensions.sth * 1.17,
                                          fontSize: Dimensions.stw * 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          color:
                                              Color.fromARGB(255, 255, 255, 255)

                                          /* letterSpacing: 0.0, */
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: ((Dimensions.myHieght * .25) * .25) *
                                    .33333,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: indicator,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.myHieght * .65,
                  width: Dimensions.myWidth,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.amber

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            prizeToShow,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0)

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: (Dimensions.myHieght * .65) * .15,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: myAmenityWidgets,
                              ),
                            ),
                          ),
                          Text(
                            'Description',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0)

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            descriptionToShow,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 0, 0, 0)

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Photos',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0)

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: (Dimensions.myHieght * .65) * .2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: (Dimensions.myHieght * .65) * .2,
                                    width: (Dimensions.myHieght * .65) * .2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              otherimageList.elementAt(1)),
                                        ),
                                        color: Colors.indigoAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: (Dimensions.myHieght * .65) * .2,
                                    width: (Dimensions.myHieght * .65) * .2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              otherimageList.elementAt(2)),
                                        ),
                                        color: Colors.indigoAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: (Dimensions.myHieght * .65) * .2,
                                    width: (Dimensions.myHieght * .65) * .2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              otherimageList.elementAt(3)),
                                        ),
                                        color: Colors.indigoAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: (Dimensions.myHieght * .65) * .2,
                                    width: (Dimensions.myHieght * .65) * .2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              otherimageList.elementAt(4)),
                                        ),
                                        color: Colors.indigoAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: (Dimensions.myHieght * .65) * .2,
                                    width: (Dimensions.myHieght * .65) * .2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              otherimageList.elementAt(5)),
                                        ),
                                        color: Colors.indigoAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Property Details',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0)

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: Dimensions.myWidth,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '   Air Conditioning',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 55, 55, 55)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Dimensions.myWidth,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '   Central Heating',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 55, 55, 55)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Dimensions.myWidth,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '   City Views',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 55, 55, 55)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Dimensions.myWidth,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '   Telephone',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 55, 55, 55)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Dimensions.myWidth,
                            height: Dimensions.sth * 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '   Internet',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 55, 55, 55)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Dimensions.myWidth,
                            height: 50,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '   General Security',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 55, 55, 55)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Location',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: Dimensions.sth * 1.17,
                                fontSize: Dimensions.stw * 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0)

                                /* letterSpacing: 0.0, */
                                ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 300,
                            width: Dimensions.myWidth,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://img.freepik.com/premium-vector/colored-city-map-with-red-pin-markers_23-2148313099.jpg?w=996')),
                                color: Color.fromARGB(255, 23, 23, 23),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              height: 50,
                              width: Dimensions.myWidth * .75,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  'Book Now',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: Dimensions.sth * 1.17,
                                      fontSize: Dimensions.stw * 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 255, 255, 255)

                                      /* letterSpacing: 0.0, */
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
