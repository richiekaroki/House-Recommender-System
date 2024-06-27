import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:location/location.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/contents_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;
enum homePageStatus {
  normal,
  seeall1,
  seeall2,
  search,
}
var homePageState = homePageStatus.normal;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    //locationChecker();
    addCurrentData();
    addSearchDisplayData();
    getMyData();

    super.initState();
  }

  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  final TextEditingController _searchController = TextEditingController();

  Future<void> locationChecker() async {
    print('checking ;location');

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService().catchError((error) {
        print(error);
      });
      if (!_serviceEnabled) {
        return;
      }
    }
    print('checking ;location2');
    _permissionGranted = await location.hasPermission();
    print('checking ;location3');
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      print('checking ;location4');
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
  }

  final pageViewController2 = PageController(
    initialPage: 2,
    viewportFraction: .5,
  );

  final pageViewController3 = PageController(
    initialPage: 2,
    viewportFraction: .4,
  );

  List<String> imageList = [
    'https://img.freepik.com/free-photo/3d-rendering-house-model_23-2150799681.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/free-photo/blue-house-with-blue-roof-sky-background_1340-25953.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/free-photo/3d-rendering-house-model_23-2150799687.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/free-photo/3d-rendering-house-model_23-2150799673.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/free-photo/design-house-modern-villa-with-open-plan-living-private-bedroom-wing-large-terrace-with-privacy_1258-169741.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph'
        'https://img.freepik.com/free-photo/3d-rendering-house-model_23-2150799661.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/free-photo/3d-rendering-house-model_23-2150799631.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/premium-photo/modern-modular-private-black-townhouses-residential_941600-7159.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/premium-photo/modern-modular-private-black-townhouses-residential_941600-7159.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/premium-photo/modern-modular-private-black-townhouses-residential_941600-7159.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/premium-photo/modern-modular-private-black-townhouses-residential_941600-7159.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
    'https://img.freepik.com/premium-photo/modern-modular-private-black-townhouses-residential_941600-7159.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
  ];

  Future getMyData() async {
    print('Starting Nelson firestore');

    CollectionReference users =
        FirebaseFirestore.instance.collection('HousePropertyDetails');
    DocumentSnapshot myfuture = await users
        .doc('KIPROTICH NELSON0748831136')
        .collection('My Uploaded Property')
        .doc('Kibet Kibet')
        .get()
        .then((value) {
      print(value.data());
      return value;
    });
  }

  String? myImage;

  Future getFireStoreData() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('HousePropertyDetails');
    print('done here');
    FutureBuilder<DocumentSnapshot>(
      future: users.doc('KIPROTICH NELSON0748831136').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Document has error");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print("Starting 2");

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print('Got it');

          setState(() {
            myImage = "${data['OtherImage1']}";

            print('$myImage');
            print('Done');
          });
        }

        return Text("loading");
      },
    );
    print('Finished  Nelson firestore');
  }

  List<AddData2>? currentAddDataList;
  List<AddData3>? searchadddataList;
  AddData3? mysearchadddata;
  String? searchString;
  int searchIntIndex = 0;

  List<Widget>? searchData;
  void addSearchDisplayData() {
    searchData = [];
    setState(() {
      myAddDataList.forEach((element) {
        searchData!.add(SearchDisplay(
            myFunction: () {},
            networkImage: element.propertyCoverImage1,
            propertyName: element.propertyName1,
            propertyPrize: element.propertyPrice1,
            propertyLocation: element.propertyLocation1));
      });
    });
  }

  void addSearchData() {
    searchadddataList = [];
    setState(() {
      myAddDataList.forEach((element) {
        searchIntIndex = 0;
        if (element.propertyType1.contains(searchString!)) {
          searchIntIndex = searchIntIndex + 1;
        } else if (element.propertyName1.contains(searchString!)) {
          searchIntIndex = searchIntIndex + 1;
        } else if (element.propertyPrice1.contains(searchString!)) {
          searchIntIndex = searchIntIndex + 1;
        } else if (element.propertyLocation1.contains(searchString!)) {
          searchIntIndex = searchIntIndex + 1;
        } else if (element.propertyAmenities1.contains(searchString!)) {
          searchIntIndex = searchIntIndex + 1;
        }
        searchadddataList!.add(AddData3(element, searchIntIndex));
      });
      AddSearchWidget();
    });
  }

  void AddSearchWidget() {
    print('Searching');
    print(searchadddataList!.length);

    searchData = [];
    for (var element in searchadddataList!) {
      print(element.indexx);
      if (element.indexx == 5) {
        searchData!.add(
          SearchDisplay(
              myFunction: () {},
              networkImage: element.adddatatwo.propertyCoverImage1,
              propertyName: element.adddatatwo.propertyName1,
              propertyPrize: element.adddatatwo.propertyPrice1,
              propertyLocation: element.adddatatwo.propertyLocation1),
        );
      }
      if (element.indexx == 4) {
        searchData!.add(
          SearchDisplay(
              myFunction: () {},
              networkImage: element.adddatatwo.propertyCoverImage1,
              propertyName: element.adddatatwo.propertyName1,
              propertyPrize: element.adddatatwo.propertyPrice1,
              propertyLocation: element.adddatatwo.propertyLocation1),
        );
      }
      if (element.indexx == 3) {
        searchData!.add(
          SearchDisplay(
              myFunction: () {},
              networkImage: element.adddatatwo.propertyCoverImage1,
              propertyName: element.adddatatwo.propertyName1,
              propertyPrize: element.adddatatwo.propertyPrice1,
              propertyLocation: element.adddatatwo.propertyLocation1),
        );
      }
      if (element.indexx == 2) {
        searchData!.add(
          SearchDisplay(
              myFunction: () {},
              networkImage: element.adddatatwo.propertyCoverImage1,
              propertyName: element.adddatatwo.propertyName1,
              propertyPrize: element.adddatatwo.propertyPrice1,
              propertyLocation: element.adddatatwo.propertyLocation1),
        );
      }
      if (element.indexx == 1) {
        searchData!.add(
          SearchDisplay(
              myFunction: () {},
              networkImage: element.adddatatwo.propertyCoverImage1,
              propertyName: element.adddatatwo.propertyName1,
              propertyPrize: element.adddatatwo.propertyPrice1,
              propertyLocation: element.adddatatwo.propertyLocation1),
        );
      }
    }
  }

  void addCurrentData() {
    currentAddDataList = [];
    setState(() {
      if (anchorState == anchorStatus.all) {
        currentAddDataList = myAddDataList;
      } else {
        if (anchorState == anchorStatus.apartment) {
          myAddDataList.forEach((element) {
            if (element.propertyType1 == 'Apartment') {
              currentAddDataList!.add(element);
            }
          });
        } else {
          if (anchorState == anchorStatus.office) {
            myAddDataList.forEach((element) {
              if (element.propertyType1 == 'Office') {
                currentAddDataList!.add(element);
              }
            });
          } else {
            if (anchorState == anchorStatus.land) {
              myAddDataList.forEach((element) {
                if (element.propertyType1 == 'Land') {
                  currentAddDataList!.add(element);
                }
              });
            } else {
              if (anchorState == anchorStatus.retail) {
                myAddDataList.forEach((element) {
                  if (element.propertyType1 == 'Retail') {
                    currentAddDataList!.add(element);
                  }
                });
              } else {
                print('Nothing Here');
              }
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    pageState = pageStatus.home;
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return // Scaffold(
        // backgroundColor: Color.fromARGB(150, 46, 34, 80),
        // bottomNavigationBar: CurvedNavigationBar(
        //   index: 0,
        //   color: Color.fromARGB(255, 40, 31, 81),
        //   height: 50,
        //   backgroundColor: Color.fromARGB(0, 255, 20, 20),
        //   items: <Widget>[
        //     BottomButtons(
        //       state: pageStatus.home,
        //       currentState: pageStatus,
        //       name: 'Home',
        //       icon: Icons.home,
        //     ),
        //     BottomButtons(
        //       state: pageStatus.search,
        //       name: 'Search',
        //       icon: Icons.search,
        //       currentState: pageStatus,
        //     ),
        //     BottomButtons(
        //       state: pageStatus.records,
        //       currentState: pageStatus,
        //       name: 'Add',
        //       icon: Icons.add_circle_outline,
        //     ),
        //     BottomButtons(
        //       state: pageStatus.messages,
        //       currentState: pageStatus,
        //       name: 'Messages',
        //       icon: Icons.message,
        //     ),
        //     BottomButtons(
        //       state: pageStatus.profile,
        //       currentState: pageStatus,
        //       name: 'Profile',
        //       icon: Icons.person,
        //     ),
        //   ],
        //   onTap: (index) {
        //     setState(() {
        //       var mIndex = index;
        //       if (index == 0) {
        //         pageState = pageStatus.home;
        //         Get.to(HomePage());
        //       } else if (index == 1) {
        //         pageState = pageStatus.search;
        //         Get.to(SearchPage());
        //       } else if (index == 2) {
        //         pageState = pageStatus.records;
        //       } else if (index == 3) {
        //         pageState = pageStatus.messages;
        //         Get.to(MessagePage());
        //       } else if (index == 4) {
        //         pageState = pageStatus.profile;
        //       }
        //     });

        //     print(pageState);
        //   },
        // ),
        // body:
        Material(
      child: Container(
        width: Dimensions.myWidth,
        height: Dimensions.myHieght * .9,
        color: Color(0xFF2E2250),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.myWidth,
                height: Dimensions.myHieght * .3333333,
                child: Column(
                  children: [
                    Container(
                      width: Dimensions.myWidth,
                      height: (Dimensions.myHieght * .3333333) * .333333,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: Dimensions.stw * 10),
                            width: Dimensions.myWidth * .70,
                            height: (Dimensions.myHieght * .3333333) * .333333,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Hello',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: Dimensions.sth * 1.17,
                                    fontSize: Dimensions.stw * 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),

                                    /* letterSpacing: 0.0, */
                                  ),
                                ),
                                Text(
                                  myName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: Dimensions.sth * 1.17,
                                    fontSize: Dimensions.stw * 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),

                                    /* letterSpacing: 0.0, */
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Dimensions.stw * 2),
                            width: Dimensions.myWidth * .20,
                            height: (Dimensions.myHieght * .3333333) * .333333,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 74, 0, 212)),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/black-boy-posing_23-2148171526.jpg?w=740&t=st=1700312023~exp=1700312623~hmac=f8f39d443be066c697aba88e49e01cf91d5847321422e19d106eba5f6f11d2bd'))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.sth * 5,
                        bottom: Dimensions.sth * 5,
                        left: Dimensions.stw * 10,
                      ),
                      width: Dimensions.myWidth,
                      height: (Dimensions.myHieght * .3333333) * .295,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: (Dimensions.myHieght * .3333333) * .20,
                            width: Dimensions.myWidth * .60,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(214, 55, 58, 97),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(196, 68, 71, 112),
                                )),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Color(0xFF4943EB),
                                  size: 30,
                                ),
                                SizedBox(
                                  width: Dimensions.myWidth * .30,
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        homePageState = homePageStatus.search;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        searchString = value;
                                        print(searchString);
                                      });
                                      addSearchData();
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        searchString = _searchController.text;
                                        if (searchString!.isNotEmpty) {
                                          print('Not Empty');
                                        } else {
                                          print(' Empty');
                                        }
                                      });
                                      addSearchData();
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 182, 219, 162),
                                    ),
                                    controller: _searchController,
                                    decoration: const InputDecoration(
                                      labelText: 'Search',
                                      labelStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 103, 131, 171)),
                                    ),
                                  ),

                                  //here
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: (Dimensions.myHieght * .3333333) * .20,
                            width: Dimensions.myWidth * .30,
                            decoration: BoxDecoration(
                                color: Color(0x854A43EB),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(196, 68, 71, 112),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.list,
                                  color: Color.fromARGB(162, 255, 255, 255),
                                  size: 30,
                                ),
                                Text(
                                  'Filters',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: Dimensions.sth * 1.17,
                                    fontSize: Dimensions.stw * 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(162, 255, 255, 255),

                                    /* letterSpacing: 0.0, */
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: Dimensions.myWidth,
                      height: (Dimensions.myHieght * .3333333) * .333333,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  anchorState = anchorStatus.all;
                                });
                                addCurrentData();
                              },
                              child: AnchorButtons(
                                state: anchorStatus.all,
                                name: 'All',
                                mycolor: Color(0xFFF0635A),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  anchorState = anchorStatus.apartment;
                                });
                                addCurrentData();
                              },
                              child: AnchorButtons(
                                  state: anchorStatus.apartment,
                                  name: 'Apartment',
                                  mycolor: Color.fromARGB(255, 246, 214, 97)),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  anchorState = anchorStatus.office;
                                });
                                addCurrentData();
                              },
                              child: AnchorButtons(
                                state: anchorStatus.office,
                                name: 'Office',
                                mycolor: Color(0xFF28D697),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  anchorState = anchorStatus.land;
                                });
                                addCurrentData();
                              },
                              child: AnchorButtons(
                                state: anchorStatus.land,
                                name: 'Land',
                                mycolor: Color(0xFF46CDFA),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  anchorState = anchorStatus.retail;
                                });
                                addCurrentData();
                              },
                              child: AnchorButtons(
                                state: anchorStatus.retail,
                                name: 'Retail',
                                mycolor: Color.fromARGB(255, 193, 70, 250),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                height: 500,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: homePageState == homePageStatus.normal
                      ? Column(
                          children: [
                            Container(
                              width: Dimensions.myWidth,
                              height: Dimensions.myHieght * .3333333,
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height:
                                        (Dimensions.myHieght * .3333333) * .2,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          anchorState == anchorStatus.all
                                              ? 'All Property'
                                              : anchorState ==
                                                      anchorStatus.apartment
                                                  ? 'Apartments'
                                                  : anchorState ==
                                                          anchorStatus.office
                                                      ? 'Office Blocks'
                                                      : anchorState ==
                                                              anchorStatus.land
                                                          ? 'Land/Plots'
                                                          : 'Retail Stores',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            height: Dimensions.sth * 1.17,
                                            fontSize: Dimensions.stw * 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),

                                            /* letterSpacing: 0.0, */
                                          ),
                                        ),
                                        Text(
                                          'See All>  ',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              height: Dimensions.sth * 1.17,
                                              fontSize: Dimensions.stw * 17,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300,
                                              color: Color(0xFF2AD798)

                                              /* letterSpacing: 0.0, */
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:
                                        (Dimensions.myHieght * .3333333) * .8,
                                    child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      allowImplicitScrolling: true,
                                      padEnds: false,
                                      controller: pageViewController2,
                                      itemCount: currentAddDataList!.length,
                                      itemBuilder: (context, index) {
                                        return HouseDisplay1(
                                            myFunction: () {
                                              setState(() {
                                                prizeToShow =
                                                    currentAddDataList!
                                                        .elementAt(index)
                                                        .propertyPrice1;
                                                amenitiesToShow =
                                                    currentAddDataList!
                                                        .elementAt(index)
                                                        .propertyAmenities1;

                                                descriptionToShow =
                                                    currentAddDataList!
                                                        .elementAt(index)
                                                        .propertyDescription1;
                                                imagetoshow =
                                                    currentAddDataList!
                                                        .elementAt(index)
                                                        .propertyCoverImage1;
                                                print(imagetoshow);
                                              });
                                              Get.to(const ContentsPage());
                                            },
                                            networkImage: currentAddDataList!
                                                .elementAt(index)
                                                .propertyCoverImage1,
                                            propertyType: currentAddDataList!
                                                .elementAt(index)
                                                .propertyType1,
                                            propertyPrize: currentAddDataList!
                                                .elementAt(index)
                                                .propertyPrice1);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: Dimensions.myWidth,
                                height: Dimensions.myHieght * .4333333,
                                child: Column(children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height:
                                        (Dimensions.myHieght * .4333333) * .15,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Featured Property',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            height: Dimensions.sth * 1.17,
                                            fontSize: Dimensions.stw * 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),

                                            /* letterSpacing: 0.0, */
                                          ),
                                        ),
                                        Text(
                                          'See All>  ',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              height: Dimensions.sth * 1.17,
                                              fontSize: Dimensions.stw * 17,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300,
                                              color: Color(0xFF2AD798)

                                              /* letterSpacing: 0.0, */
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:
                                        (Dimensions.myHieght * .4333333) * .85,
                                    child: PageView.builder(
                                      scrollDirection: Axis.vertical,
                                      allowImplicitScrolling: true,
                                      padEnds: false,
                                      controller: pageViewController3,
                                      itemCount: currentAddDataList!.length,
                                      itemBuilder: (context, index) {
                                        return HouseDisplay2(
                                          myFunction: () {
                                            setState(() {
                                              prizeToShow = currentAddDataList!
                                                  .elementAt(index)
                                                  .propertyPrice1;
                                              amenitiesToShow =
                                                  currentAddDataList!
                                                      .elementAt(index)
                                                      .propertyAmenities1;

                                              descriptionToShow =
                                                  currentAddDataList!
                                                      .elementAt(index)
                                                      .propertyDescription1;
                                              imagetoshow = currentAddDataList!
                                                  .elementAt(index)
                                                  .propertyCoverImage1;
                                              print(imagetoshow);
                                            });
                                            Get.to(const ContentsPage());
                                          },
                                          networkImage: currentAddDataList!
                                              .elementAt(index)
                                              .propertyCoverImage1,
                                          propertyPrize: currentAddDataList!
                                              .elementAt(index)
                                              .propertyPrice1,
                                          propertyLocation: currentAddDataList!
                                              .elementAt(index)
                                              .propertyLocation1,
                                          propertyName: currentAddDataList!
                                              .elementAt(index)
                                              .propertyName1,
                                        );
                                      },
                                    ),
                                  ),
                                ])),
                          ],
                        )
                      : homePageState == homePageStatus.search
                          ? Column(
                              children: searchData!,
                            )
                          : homePageState == homePageStatus.seeall1
                              ? Column()
                              : Column(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}
