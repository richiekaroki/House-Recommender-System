import 'dart:ffi';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Helpers/Utility.dart';
import 'package:the_tolet/Pages/add_page.dart';
import 'package:the_tolet/Pages/all_pagecontroller.dart';

import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;
Image? myProfilePic;
List<Image> otherImages = [];
AddData? mydata;

class AddingPage extends StatefulWidget {
  const AddingPage({Key? key}) : super(key: key);

  @override
  _AddingPage createState() => _AddingPage();
}

bool show = true;
bool hide = false;

bool show1 = true;
bool hide1 = false;

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

String dropdownvalue = 'Item 1';

// List of items in our dropdown menu
var items = [
  'Apartment',
  'Office',
  'Retail',
  'Land',
  'Schools',
];

String propertyTypeSelectedString = '';
String propertyTypeNameString = '';
String propertyTypePriceString = '';
String propertyTypeLocationString = '';
String propertyTypeAdressString = '';
List<Amenities>? propertyAmenities;
String propertyDescriptionstring = '';
File? propertyCoverImage;
List<File>? propertyOtherImages;
String propertyContactNamestring = '';
String propertyContactPhonestring = '';

TextEditingController propertyNameController = TextEditingController();
TextEditingController propertyPriceController = TextEditingController();
TextEditingController propertyLocationController = TextEditingController();
TextEditingController propertyAdressController = TextEditingController();
TextEditingController propertyDescriptionController = TextEditingController();
TextEditingController propertyContactNameController = TextEditingController();
TextEditingController propertyContactPhoneController = TextEditingController();
bool coverorother = false;
DocumentReference<Map<String, dynamic>>? properttyUser;

class _AddingPage extends State<AddingPage> {
  final _firebaseStorage = FirebaseStorage.instance;
  String? downloadedCover;

  Future getDownloadUrlString() async {
    print('Starting to download');
    if (snapshott == null) {
      print('Null');
    } else {
      String url = (await snapshott.ref.getDownloadURL()).toString();
      print(url);
      downloadedCover = url;
      uploadOtherImage();
    }
  }

  List<String> downloadedOtherImagesString = [];

  Future getDownloadUrlOthersString() async {
    print('Starting to download other Image');
    String url = (await snapshot2.ref.getDownloadURL()).toString();
    downloadedOtherImagesString.add(url);
    print(url);

    print(downloadedOtherImagesString.length);
  }

  var snapshott;

  Future uploadImage() async {
    if (Dimensions.finalImage != null) {
      snapshott = await _firebaseStorage
          .ref()
          .child('/Property')
          .child('/' + mydata!.propertyName)
          .child(mydata!.propertyName)
          .putFile(mydata!.propertyCoverImage);

      if (snapshott == null) {
        print('Null');
      } else {
        String url = (await snapshott.ref.getDownloadURL()).toString();
        print(url);
        downloadedCover = url;
        uploadOtherImage();
      }

      print(snapshott.toString());
    } else {
      print(Dimensions.finalImage.toString());
      print('none');
      print('Hey nelson its ' + Dimensions.finalImage.toString());
    }
  }

  var snapshot2;

  Future uploadOtherImage() async {
    downloadedOtherImagesString = [];
    for (var element in imagefiles2) {
      if (imagefiles2 != null) {
        snapshot2 = await _firebaseStorage
            .ref()
            .child('/Property')
            .child('/' + mydata!.propertyName)
            .child('/OtherProperty')
            .child(
                imagefiles2.indexOf(element).toString() + mydata!.propertyName)
            .putFile(element);
        if (snapshot2 == null) {
          print('Null');
        } else {
          String url = (await snapshot2.ref.getDownloadURL()).toString();
          downloadedOtherImagesString.add(url);

          print('Image 1' +
              (downloadedOtherImagesString.length.toString()) +
              url);
        }

        print('Finished Uploading image');
      } else {
        print(Dimensions.finalImage.toString());
        print('none');
        print('Hey nelson its ' + Dimensions.finalImage.toString());
      }
    }
    uploadUsersData();
    // Get.to(const AllPages());
  }

  File? image;
  loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      if (coverorother == true) {
        setState(() {
          myProfilePic = Utility.imageFromBase64String(img);
        });
      } else {
        setState(() {
          otherImages.add(Utility.imageFromBase64String(img));
        });
      }
    });
  }

  File? imagefile;
  File? imagefileBeta;
  List<File>? imagefiles;
  List<File> imagefiles2 = [];

  void DetectsWhichImage() {
    if (coverorother == true) {
      print('cover');

      setState(() {
        imagefile = imagefileBeta;
      });
    } else {
      setState(() {
        print('Other');
        imagefiles = [];

        imagefiles2.add(imagefileBeta!);
        imagefiles!.add(imagefileBeta!);
      });
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = image != null ? File(image.path) : null;

      setState(() {
        this.image = imageTemp;
        imagefileBeta = imageTemp;

        if (this.image != null) {
          Dimensions.finalImage = this.image;
          Utility.saveImageToPreferences(
              Utility.base64String(Dimensions.finalImage!.readAsBytesSync()));
          setState(() {
            loadImageFromPreferences();
            DetectsWhichImage();

            print('not none');
            print('Hey nelson its ' + Dimensions.finalImage.toString());
          });
        } else {
          Dimensions.finalImage = null;
          this.image = null;

          print(Dimensions.finalImage);
          print('none');
          print('Hey nelson its ' + Dimensions.finalImage.toString());
        }

        // _cropImage();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = image != null ? File(image.path) : null;

      setState(() {
        this.image = imageTemp;
        imagefileBeta = imageTemp;

        if (this.image != null) {
          Dimensions.finalImage = this.image;
          Utility.saveImageToPreferences(
              Utility.base64String(Dimensions.finalImage!.readAsBytesSync()));
          setState(() {
            loadImageFromPreferences();
            DetectsWhichImage();

            print('not none');
            print('Hey nelson its ' + Dimensions.finalImage.toString());
          });
        } else {
          Dimensions.finalImage = null;
          this.image = null;

          print(Dimensions.finalImage);
          print('none');
          print('Hey nelson its ' + Dimensions.finalImage.toString());
        }

        // _cropImage();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<Null> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
            ]
          : [
              CropAspectRatioPreset.square,
            ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit Your Profile',
          toolbarColor: Color.fromARGB(255, 4, 154, 24),
          hideBottomControls: false,
          toolbarWidgetColor: Color.fromARGB(255, 255, 255, 255),
          activeControlsWidgetColor: Color.fromARGB(255, 236, 244, 0),
        ),
      ],
    );

    if (croppedFile != null) {
      Dimensions.finalImage = croppedFile as File?;

      Utility.saveImageToPreferences(
          Utility.base64String(Dimensions.finalImage!.readAsBytesSync()));

      setState(() {
        loadImageFromPreferences();

        Dimensions.finalImage = croppedFile as File?;
        print('not none');
        print('Hey nelson its ' + Dimensions.finalImage.toString());
      });
    } else {
      Dimensions.finalImage = null;
      image = null;
      print(Dimensions.finalImage);
      print('none');
      print('Hey nelson its ' + Dimensions.finalImage.toString());
    }
  }

  void checkbool() {
    if (show == false) {
      hide = true;
    } else {
      hide = false;
    }
  }

  void checkbool1() {
    if (show1 == false) {
      hide1 = true;
    } else {
      hide1 = false;
    }
  }

  @override
  void initState() {}

  final pageViewController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  List<Widget>? myOtherImages;
  List<Widget> selectedAmenityWidget = [];

  bool propertyTypeError = false;
  bool propertyNameError = false;
  bool propertyPriceError = false;
  bool propertyLocationError = false;
  bool propertyAmenitiesError = false;
  bool propertydescriptionError = false;
  bool propertyAddCoverError = false;
  bool propertyAddOtherError = false;
  bool propertyContactError = false;

  int propertyTypeSelected = 0;

  void adduploadData() {
    setState(() {
      uploadingData = true;
      mydata = AddData(
          propertyTypeSelectedString,
          propertyTypeNameString,
          propertyTypePriceString,
          propertyTypeLocationString,
          propertyTypeAdressString,
          propertyAmenities!,
          propertyDescriptionstring,
          propertyCoverImage!,
          propertyOtherImages!,
          propertyContactNamestring,
          propertyContactPhonestring);
    });
    myUID = mydata!.propertyName;
    uploadImage();
  }

  Future uploadUsersData() {
    setState(() {
      myUID = mydata!.propertyName;
      properttyUser = FirebaseFirestore.instance
          .collection('HousePropertyDetails')
          .doc(myName + myPhoneNumber)
          .collection('My Uploaded Property')
          .doc(mydata!.propertyContactName);
    });

    print('startingto upload user documents');

    return properttyUser!
        .set({
          'PropertySelected': mydata!.propertyType,
          'PropertyName': mydata!.propertyName,
          'PropertyPrice': mydata!.propertyPrice,
          'PropertyLocation': mydata!.propertyLocation,
          'PropertyAdress': mydata!.propertyAdress,
          'PropertyDescription': mydata!.propertyDescription,
          'PropertyContactName': mydata!.propertyContactName,
          'PropertyContactPhone': mydata!.propertyContactPhone,
          'PropertyCoverImage': downloadedCover,
          'OtherImage1': downloadedOtherImagesString.isNotEmpty
              ? downloadedOtherImagesString.elementAt(0)
              : '',
          'OtherImage2': downloadedOtherImagesString.length >= 2
              ? downloadedOtherImagesString.elementAt(1)
              : '',
          'OtherImage3': downloadedOtherImagesString.length >= 3
              ? downloadedOtherImagesString.elementAt(2)
              : '',
          'OtherImage4': downloadedOtherImagesString.length >= 4
              ? downloadedOtherImagesString.elementAt(3)
              : '',
          'OtherImage5': downloadedOtherImagesString.length >= 5
              ? downloadedOtherImagesString.elementAt(4)
              : '',
          'OtherImage6': downloadedOtherImagesString.length >= 6
              ? downloadedOtherImagesString.elementAt(5)
              : '',
          'OtherImage7': downloadedOtherImagesString.length >= 7
              ? downloadedOtherImagesString.elementAt(6)
              : '',
        })
        .timeout(Duration(seconds: 10))
        .then((value) => uploadOtherImageData())
        .catchError((error) {
          print("Failed to add user: $error");
        })
        .whenComplete(() => returnState());
  }

  void returnState() {
    setState(() {
      uploadingData = false;
    });
  }

  bool uploadingData = false;

  void uploadOtherImageData() {
    print('Fully Done');
  }

  void propertytypechecker() {
    setState(() {
      if (propertyTypeSelected == 1) {
        propertyTypeSelectedString = 'Mixed';
      } else {
        if (propertyTypeSelected == 2) {
          propertyTypeSelectedString = 'Apartment';
        } else {
          if (propertyTypeSelected == 3) {
            propertyTypeSelectedString = 'Office';
          } else {
            if (propertyTypeSelected == 4) {
              propertyTypeSelectedString = 'Retail';
            } else {
              if (propertyTypeSelected == 5) {
                propertyTypeSelectedString = 'Land';
              } else {
                if (propertyTypeSelected == 6) {
                  propertyTypeSelectedString = 'School';
                }
              }
            }
          }
        }
      }
    });
  }

  int selectedAmenitiesNumber = 0;
  void checkselectedamenities() {
    propertyAmenities = [];
    setState(() {
      selectedAmenitiesNumber = 0;
      amenityList.forEach((element) {
        if (element.selectionbool == true) {
          selectedAmenitiesNumber = selectedAmenitiesNumber + 1;
          propertyAmenities!.add(Amenities(element.selectionbool,
              element.amenityname, element.amenityNumber));
        }
      });
    });
  }

  void dataChecker() {
    setState(() {
      if (propertyTypeSelected > 0) {
        propertyTypeError = false;
        propertytypechecker();

        if (propertyNameController.text.length < 2) {
          propertyNameError = true;
        } else {
          propertyTypeNameString = propertyNameController.text;
          propertyNameError = false;
          if (propertyPriceController.text.length < 2) {
            propertyPriceError = true;
          } else {
            propertyTypePriceString = propertyPriceController.text;
            propertyPriceError = false;
            if (propertyLocationController.text.length < 2) {
              propertyLocationError = true;
            } else {
              propertyTypeLocationString = propertyLocationController.text;

              propertyLocationError = false;

              checkselectedamenities();

              if (selectedAmenitiesNumber < 4) {
                propertyAmenitiesError = true;
              } else {
                propertyAmenitiesError = false;

                if (propertyDescriptionController.text.length < 100) {
                  propertydescriptionError = true;
                } else {
                  propertyDescriptionstring =
                      propertyDescriptionController.text;
                  propertydescriptionError = false;
                  if (imagefile == null) {
                    propertyAddCoverError = true;
                  } else {
                    propertyCoverImage = imagefile;

                    propertyAddCoverError = false;
                    if (imagefiles2 == null) {
                      propertyAddOtherError = true;
                    } else {
                      propertyOtherImages = imagefiles2;
                      propertyAddOtherError = false;
                      if (propertyContactNameController.text.length < 2) {
                        propertyContactError = true;
                      } else {
                        propertyContactNamestring =
                            propertyContactNameController.text;
                        propertyContactError = false;
                        if (propertyContactPhoneController.text.length < 2) {
                          propertyContactError = true;
                        } else {
                          propertyContactPhonestring =
                              propertyContactPhoneController.text;
                          propertyContactError = false;
                          adduploadData();
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        propertyTypeError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedAmenityWidget = [];
    amenityList.forEach((element) {
      selectedAmenityWidget.add(SelectionWidget1(
          mytextStrng: element.amenityname,
          callback: () {
            setState(() {
              if (element.selectionbool == true) {
                element.selectionbool = false;
              } else {
                element.selectionbool = true;
              }
            });
          },
          state: element.selectionbool));
    });
    if (imagefiles == null) {
      myOtherImages = [];
      myOtherImages!.add(OtherImageWidget(
        imageFiless: [],
        index: 0,
        decider: 0,
      ));
    } else {
      myOtherImages = [];
      imagefiles2.forEach((element) {
        myOtherImages!.add(OtherImageWidget(
          imageFiless: imagefiles2,
          index: imagefiles2.indexOf(element),
          decider: 1,
        ));
      });
    }

    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Scaffold(
      body: Material(
        child: Container(
          color: Color(0xFF2E2250),
          child: uploadingData == false
              ? Column(
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
                      width: Dimensions.myWidth,
                      height: Dimensions.myHieght * .9,
                      decoration: const BoxDecoration(
                        color: ui.Color.fromARGB(66, 10, 64, 78),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1.  Please select property type.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyTypeError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SelectionWidget(
                                        mytextStrng: 'Mixed',
                                        callback: () {
                                          setState(() {
                                            selectedstate =
                                                selectionstates.mixed;
                                            propertyTypeSelected = 1;
                                            propertyTypeSelectedString =
                                                'Mixed';
                                            propertyTypeError = false;
                                          });
                                        },
                                        state: selectionstates.mixed,
                                      ),
                                      SelectionWidget(
                                        mytextStrng: 'Apartment',
                                        callback: () {
                                          setState(() {
                                            selectedstate =
                                                selectionstates.apartment;
                                            propertyTypeSelected = 2;
                                            propertyTypeSelectedString =
                                                'Apartment';
                                            propertyTypeError = false;
                                          });
                                        },
                                        state: selectionstates.apartment,
                                      ),
                                      SelectionWidget(
                                        mytextStrng: 'Office',
                                        callback: () {
                                          setState(() {
                                            selectedstate =
                                                selectionstates.office;
                                            propertyTypeSelected = 3;
                                            propertyTypeSelectedString =
                                                'Office';
                                            propertyTypeError = false;
                                          });
                                        },
                                        state: selectionstates.office,
                                      ),
                                      SelectionWidget(
                                        mytextStrng: 'Retail',
                                        callback: () {
                                          setState(() {
                                            selectedstate =
                                                selectionstates.retail;
                                            propertyTypeSelected = 4;
                                            propertyTypeSelectedString =
                                                'Retail';
                                            propertyTypeError = false;
                                          });
                                        },
                                        state: selectionstates.retail,
                                      ),
                                      SelectionWidget(
                                        mytextStrng: 'Land',
                                        callback: () {
                                          setState(() {
                                            selectedstate =
                                                selectionstates.land;
                                            propertyTypeSelected = 5;
                                            propertyTypeSelectedString = 'Land';
                                            propertyTypeError = false;
                                          });
                                        },
                                        state: selectionstates.land,
                                      ),
                                      SelectionWidget(
                                        mytextStrng: 'Schools',
                                        callback: () {
                                          setState(() {
                                            selectedstate =
                                                selectionstates.schools;
                                            propertyTypeSelected = 6;
                                            propertyTypeSelectedString =
                                                'Schools';
                                            propertyTypeError = false;
                                          });
                                        },
                                        state: selectionstates.schools,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '2. Please Enter Property Name.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyNameError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyNameController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: ' Hilton Aprt',
                                  colorDecider: 1,
                                  myicon: Icons.house_rounded,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '3. Please Enter Property Price.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyPriceError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyPriceController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: 'KSH 20,000',
                                  colorDecider: 1,
                                  myicon: Icons.money_outlined,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '4. Please Enter Property Location.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyLocationError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyLocationController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: 'Nairobi Kenya',
                                  colorDecider: 1,
                                  myicon: Icons.location_on,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '5. Please Enter Property Adress (optional).',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 255, 255, 255),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyAdressController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: 'p.o Box 20200 Kericho',
                                  colorDecider: 1,
                                  myicon: Icons.pin_rounded,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '6. Please select available Property amenities.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyAmenitiesError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: selectedAmenityWidget,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '7. Please in not less than 200 words give projects description',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertydescriptionError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyDescriptionController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: 'Desc.....',
                                  colorDecider: 1,
                                  myicon: Icons.description_outlined,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '8. Please add project cover image.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyAddCoverError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: Dimensions.myWidth * .45,
                                width: Dimensions.myWidth * .45,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(61, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                                child: Center(
                                  // child: Icon(
                                  // Icons.add_photo_alternate_outlined,
                                  // size: 60,
                                  // color: Color.fromARGB(105, 254, 254, 254),
                                  // ),
                                  child: Container(
                                    height: Dimensions.myWidth * .45,
                                    width: Dimensions.myWidth * .45,
                                    child: Container(
                                      child: Container(
                                        height: Dimensions.myWidth * .45,
                                        width: Dimensions.myWidth * .45,
                                        child: Stack(
                                          fit: StackFit.loose,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  show = false;
                                                  print('False');
                                                  checkbool();
                                                });
                                              },
                                              child: SizedBox(
                                                height:
                                                    Dimensions.myWidth * .45,
                                                width: Dimensions.myWidth * .45,
                                                child: Visibility(
                                                  visible: show,
                                                  child: Container(
                                                      height:
                                                          Dimensions.myWidth *
                                                              .45,
                                                      width:
                                                          Dimensions.myWidth *
                                                              .45,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: imagefile == null
                                                          ? Icon(
                                                              Icons
                                                                  .add_photo_alternate_outlined,
                                                              size: 90 *
                                                                  Dimensions
                                                                      .stw,
                                                              color: ui.Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      0.557),
                                                            )
                                                          : Container(
                                                              height: Dimensions
                                                                      .myWidth *
                                                                  .45,
                                                              width: Dimensions
                                                                      .myWidth *
                                                                  .45,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          Dimensions.myWidth *
                                                                              .45,
                                                                      width: Dimensions
                                                                              .myWidth *
                                                                          .45,
                                                                      child: imagefile ==
                                                                              null
                                                                          ? const SizedBox(
                                                                              height: 0,
                                                                              width: 0,
                                                                            )
                                                                          : Image
                                                                              .file(
                                                                              imagefile!,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          Dimensions.myWidth *
                                                                              .45,
                                                                      width: Dimensions
                                                                              .myWidth *
                                                                          .45,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .restart_alt_outlined,
                                                                        size: 80 *
                                                                            Dimensions.stw,
                                                                        color: ui.Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.749),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                ),
                                              ),
                                            ),

                                            //SELECTIN CAMERA OR GALLERY
                                            GestureDetector(
                                              child: Visibility(
                                                visible: hide,
                                                child: Container(
                                                  color: Color.fromARGB(
                                                      0, 18, 43, 233),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              coverorother =
                                                                  true;
                                                              show = true;
                                                              print('False');
                                                              checkbool();
                                                              pickImage();
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 150 *
                                                                Dimensions.sth,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Dimensions
                                                                          .stw *
                                                                      10,
                                                                ),
                                                                Text(
                                                                  'Gallary',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Dimensions.stw *
                                                                            16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Container(
                                                                  child: Icon(
                                                                    Icons
                                                                        .photo_sharp,
                                                                    color: Color(
                                                                        0xBCFFFFFF),
                                                                    size: 30,
                                                                  ),
                                                                  height: Dimensions
                                                                          .sth *
                                                                      40,
                                                                  width: Dimensions
                                                                          .sth *
                                                                      40,
                                                                )
                                                              ],
                                                            ),
                                                            height:
                                                                Dimensions.sth *
                                                                    40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                              .stw *
                                                                          10),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment(
                                                                    -0.880733858848594,
                                                                    -1.0000017019399792),
                                                                end: Alignment(
                                                                    0.99999997189021,
                                                                    1.2769217932640622),
                                                                stops: [
                                                                  0.0,
                                                                  1.0
                                                                ],
                                                                colors: [
                                                                  Color
                                                                      .fromARGB(
                                                                          127,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  Color
                                                                      .fromARGB(
                                                                          51,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20 *
                                                              Dimensions.sth,
                                                          child: Center(
                                                            child: Text(
                                                              'OR',
                                                              style: TextStyle(
                                                                color: ui.Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        1),
                                                                fontSize:
                                                                    Dimensions
                                                                            .stw *
                                                                        16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              coverorother =
                                                                  true;
                                                              show = true;
                                                              print('False');
                                                              checkbool();
                                                              pickImageC();
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 150 *
                                                                Dimensions.sth,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Dimensions
                                                                          .stw *
                                                                      10,
                                                                ),
                                                                Text(
                                                                  'Camera',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Dimensions.stw *
                                                                            16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Container(
                                                                  child: Icon(
                                                                    Icons
                                                                        .camera_alt_sharp,
                                                                    color: ui
                                                                            .Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.745),
                                                                    size: 30,
                                                                  ),
                                                                  height: 40,
                                                                  width: 40,
                                                                )
                                                              ],
                                                            ),
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                              .stw *
                                                                          10),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment(
                                                                    -0.880733858848594,
                                                                    -1.0000017019399792),
                                                                end: Alignment(
                                                                    0.99999997189021,
                                                                    1.2769217932640622),
                                                                stops: [
                                                                  0.0,
                                                                  1.0
                                                                ],
                                                                colors: [
                                                                  Color
                                                                      .fromARGB(
                                                                          127,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  Color
                                                                      .fromARGB(
                                                                          51,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: Dimensions.myWidth * .45,
                                      width: Dimensions.myWidth * .4,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '9. Please add other project  images.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyAddOtherError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: Dimensions.myWidth * .45,
                                width: Dimensions.myWidth * .45,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(61, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                                child: Center(
                                  // child: Icon(
                                  // Icons.add_photo_alternate_outlined,
                                  // size: 60,
                                  // color: Color.fromARGB(105, 254, 254, 254),
                                  // ),
                                  child: Container(
                                    height: Dimensions.myWidth * .45,
                                    width: Dimensions.myWidth * .45,
                                    child: Container(
                                      child: Container(
                                        height: Dimensions.myWidth * .45,
                                        width: Dimensions.myWidth * .45,
                                        child: Stack(
                                          fit: StackFit.loose,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  show1 = false;
                                                  print('False');
                                                  checkbool1();
                                                });
                                              },
                                              child: SizedBox(
                                                height:
                                                    Dimensions.myWidth * .45,
                                                width: Dimensions.myWidth * .45,
                                                child: Visibility(
                                                  visible: show1,
                                                  child: Container(
                                                      height:
                                                          Dimensions.myWidth *
                                                              .45,
                                                      width:
                                                          Dimensions.myWidth *
                                                              .45,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .add_photo_alternate_outlined,
                                                            size: 90 *
                                                                Dimensions.stw,
                                                            color: ui.Color
                                                                .fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    0.557),
                                                          ),
                                                          Text(
                                                            'Click here',
                                                            style: TextStyle(
                                                              color: ui.Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                              fontSize:
                                                                  Dimensions
                                                                          .stw *
                                                                      16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ),

                                            //SELECTIN CAMERA OR GALLERY
                                            GestureDetector(
                                              child: Visibility(
                                                visible: hide1,
                                                child: Container(
                                                  color: Color.fromARGB(
                                                      0, 18, 43, 233),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              coverorother =
                                                                  false;
                                                              show1 = true;
                                                              print('False');
                                                              checkbool1();
                                                              pickImage();
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 150 *
                                                                Dimensions.sth,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Dimensions
                                                                          .stw *
                                                                      10,
                                                                ),
                                                                Text(
                                                                  'Gallary',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Dimensions.stw *
                                                                            16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Container(
                                                                  child: Icon(
                                                                    Icons
                                                                        .photo_sharp,
                                                                    color: Color(
                                                                        0xBCFFFFFF),
                                                                    size: 30,
                                                                  ),
                                                                  height: Dimensions
                                                                          .sth *
                                                                      40,
                                                                  width: Dimensions
                                                                          .sth *
                                                                      40,
                                                                )
                                                              ],
                                                            ),
                                                            height:
                                                                Dimensions.sth *
                                                                    40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                              .stw *
                                                                          10),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment(
                                                                    -0.880733858848594,
                                                                    -1.0000017019399792),
                                                                end: Alignment(
                                                                    0.99999997189021,
                                                                    1.2769217932640622),
                                                                stops: [
                                                                  0.0,
                                                                  1.0
                                                                ],
                                                                colors: [
                                                                  Color
                                                                      .fromARGB(
                                                                          127,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  Color
                                                                      .fromARGB(
                                                                          51,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20 *
                                                              Dimensions.sth,
                                                          child: Center(
                                                            child: Text(
                                                              'OR',
                                                              style: TextStyle(
                                                                color: ui.Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        1),
                                                                fontSize:
                                                                    Dimensions
                                                                            .stw *
                                                                        16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              coverorother =
                                                                  false;
                                                              show1 = true;
                                                              print('False');
                                                              checkbool1();
                                                              pickImageC();
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 150 *
                                                                Dimensions.sth,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Dimensions
                                                                          .stw *
                                                                      10,
                                                                ),
                                                                Text(
                                                                  'Camera',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Dimensions.stw *
                                                                            16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Container(
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .camera_alt_sharp,
                                                                    color: ui
                                                                            .Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.745),
                                                                    size: 30,
                                                                  ),
                                                                  height: 40,
                                                                  width: 40,
                                                                )
                                                              ],
                                                            ),
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                              .stw *
                                                                          10),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment(
                                                                    -0.880733858848594,
                                                                    -1.0000017019399792),
                                                                end: Alignment(
                                                                    0.99999997189021,
                                                                    1.2769217932640622),
                                                                stops: [
                                                                  0.0,
                                                                  1.0
                                                                ],
                                                                colors: [
                                                                  Color
                                                                      .fromARGB(
                                                                          127,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  Color
                                                                      .fromARGB(
                                                                          51,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: Dimensions.myWidth * .45,
                                      width: Dimensions.myWidth * .4,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: myOtherImages!,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '10. Please enter  project  contact name and phone.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: Dimensions.sth * 1.17,
                                  fontSize: Dimensions.stw * 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: propertyContactError == false
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : ui.Color.fromARGB(255, 255, 133, 133),

                                  /* letterSpacing: 0.0, */
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyContactNameController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: 'Brian Kibet',
                                  colorDecider: 1,
                                  myicon: Icons.person_add,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 80 * Dimensions.sth,
                                child: TextFields1(
                                  myController: propertyContactPhoneController,
                                  onsubmit: () {},
                                  textFormFieldFunction: () {},
                                  inputType: TextInputType.name,
                                  myHintStrng: '+254748831136',
                                  colorDecider: 1,
                                  myicon: Icons.phone_android,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: Dimensions.myWidth,
                                child: GestureDetector(
                                  onTap: () {
                                    dataChecker();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    height: 60 * Dimensions.sth,
                                    width: Dimensions.myWidth * .5,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Upload Now',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          height: Dimensions.sth * 1.17,
                                          fontSize: Dimensions.stw * 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),

                                          /* letterSpacing: 0.0, */
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  height: Dimensions.myHieght,
                  width: Dimensions.myWidth,
                  color: ui.Color.fromARGB(255, 90, 7, 255),
                  child: Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        )),
                  ),
                ),
        ),
      ),
    );
  }
}
