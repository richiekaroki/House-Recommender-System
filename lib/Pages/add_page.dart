import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Helpers/firebase_file.dart';
import 'package:the_tolet/Pages/adding_page.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/messages_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Color changinText1 = Colors.amber;

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPage createState() => _AddPage();
}

class _AddPage extends State<AddPage> with TickerProviderStateMixin {
  ListResult? downloadeddata;

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);

    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;

          final file = FirebaseFile(
            ref: ref,
            name: name,
            url: url,
          );

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/${ref.name}/');

    await ref.writeToFile(file);
  }

  @override
  void initState() {
    // downloadImageData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageState = pageStatus.records;
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Container(
      color: Color(0xFF2E2250),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'ADD PROPERTY',
            textAlign: TextAlign.left,
            style: TextStyle(
              height: Dimensions.sth * 1.17,
              fontSize: Dimensions.stw * 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 255, 255, 255),

              /* letterSpacing: 0.0, */
            ),
          ),
          SizedBox(
            height: 30 * Dimensions.sth,
          ),
          Container(
            height: Dimensions.myHieght * .8,
            decoration: BoxDecoration(
              color: Color.fromARGB(66, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 15),
                    child: Container(
                      height: Dimensions.myHieght * .25,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(89, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 15,
                              bottom: 10,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'ADD',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: Dimensions.sth * 1.17,
                                    fontSize: Dimensions.stw * 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 255, 255),

                                    /* letterSpacing: 0.0, */
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(AddingPage());
                                  },
                                  child: Container(
                                    height: Dimensions.myHieght * .2,
                                    width: Dimensions.myWidth * .4,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(42, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Icon(
                                        Icons.add_circle_outline,
                                        size: 75,
                                        color: Color.fromRGBO(
                                            244, 244, 244, 0.556),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 15,
                              bottom: 10,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'REMOVE',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: Dimensions.sth * 1.17,
                                    fontSize: Dimensions.stw * 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 255, 255),

                                    /* letterSpacing: 0.0, */
                                  ),
                                ),
                                Container(
                                  height: Dimensions.myHieght * .2,
                                  width: Dimensions.myWidth * .4,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(42, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      size: 75,
                                      color:
                                          Color.fromRGBO(244, 244, 244, 0.556),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'MY PROPERTIES',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        height: Dimensions.sth * 1.17,
                        fontSize: Dimensions.stw * 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 255, 255),

                        /* letterSpacing: 0.0, */
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 46, 34, 80),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 290 * Dimensions.sth,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 48, 54, 90),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: 200 * Dimensions.sth,
                                    width: Dimensions.myWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            'https://img.freepik.com/free-photo/3d-rendering-house-model_23-2150799681.jpg?size=626&ext=jpg&ga=GA1.1.794232657.1669117246&semt=sph',
                                          )),
                                    ),
                                  ),
                                  Container(
                                    color: Color.fromARGB(255, 61, 7, 111),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: ((Dimensions.myHieght *
                                                      .3333333) *
                                                  .20) *
                                              .5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Hilton Apartment    ',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  height: Dimensions.sth * 1.17,
                                                  fontSize: Dimensions.stw * 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),

                                                  /* letterSpacing: 0.0, */
                                                ),
                                              ),
                                              Text(
                                                'KSH 20,000',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  height: Dimensions.sth * 1.17,
                                                  fontSize: Dimensions.stw * 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 98, 92, 255),

                                                  /* letterSpacing: 0.0, */
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              Text(
                                                '  Juja Kiambu Kenya',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  height: Dimensions.sth * 1.17,
                                                  fontSize: Dimensions.stw * 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),

                                                  /* letterSpacing: 0.0, */
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: ((Dimensions.myHieght *
                                                      .3333333) *
                                                  .20) *
                                              .5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '200SQFT',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  height: Dimensions.sth * 1.17,
                                                  fontSize: Dimensions.stw * 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 133, 210, 50),

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
                                                  color: Color.fromARGB(
                                                      255, 255, 184, 92),

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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
