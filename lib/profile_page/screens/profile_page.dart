import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_it/common/providers/sharedpref.dart';
import 'package:learn_it/common/routes/app_routes.dart';
import 'package:learn_it/common/utils/screen_size.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;

  Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      print("Inside Picker----");
      var pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
        await UserLoginDetails.setProfilePicture(pickedImage.path);
      }
      return image;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => SnackBar(content: Text(e.toString())),
      );
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (UserLoginDetails.getdp() != null) {
      image = File(UserLoginDetails.getdp()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    void selectImage() async {
      print("Function Called");
      image = await pickImageFromGallery(context);

      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(children: [
            //Profile Banner
            // profileBanner(width, height, selectImage, image),

            Container(
              height: SizeConfig.height! * 70,
              width: SizeConfig.width! * 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
                      height: SizeConfig.height! * 60,
                      width: SizeConfig.width! * 80,
                      decoration: BoxDecoration(
                        color: Color(0xfffffff),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 10,
                          color: Color(0xffD9D9D9),
                        ),
                      ),
                      child: Stack(children: [
                        Positioned(
                            child: Container(
                          height: SizeConfig.height! * 20,
                          width: SizeConfig.width! * 80,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 195, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                        )),
                        Positioned(
                          top: SizeConfig.height! * 15,
                          left: SizeConfig.width! * 22,
                          child: SizedBox(
                            height: width * 0.25,
                            width: width * 0.3,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: width * 0.2,
                                  width: width * 0.2,
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            blurStyle: BlurStyle.outer,
                                            color: Color.fromARGB(
                                                255, 255, 254, 254),
                                            offset: Offset(0, 0))
                                      ],
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          color: const Color.fromARGB(
                                              255, 214, 226, 246),
                                          width: 2),
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: image == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(width),
                                          child: const Image(
                                            image: AssetImage(
                                                "assets/avatars/profile picture.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(width),
                                          child: Image(
                                            image: FileImage(image!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                //Adding photo
                                Positioned(
                                  right: width * 0.025,
                                  bottom: 5,
                                  child: Container(
                                    height: width * 0.08,
                                    width: width * 0.1,
                                    alignment: Alignment.topCenter,
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(125, 9, 43, 101),
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      onPressed: selectImage,
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                      ),
                                      iconSize: width * 0.04,
                                    ),
                                  ),
                                ),

                                Positioned(
                                    top: SizeConfig.height! * 50,
                                    left: SizeConfig.width! * 20,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Name",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),

            //Logout button
            Padding(
                padding: EdgeInsets.all(width * 0.035),
                child: FilledButton(
                    child: const Text("Log Out"),
                    onPressed: () {
                      const storage = FlutterSecureStorage();
                      storage.delete(key: "jwt");
                      UserLoginDetails.clearData();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.onboardingscreen, (route) => false);
                    }))
          ])
        ],
      ),
    );
  }

  Padding profileBanner(
      double width, double height, VoidCallback selectImage, File? image) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: width * 0.035, horizontal: width * 0.035),
      child: Container(
        height: height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(height * 0.05, height * 0.05),
            bottomLeft: Radius.circular(height * 0.05),
          ),
          border: Border.all(
              style: BorderStyle.solid, color: Colors.white, width: 3),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
                color: Color.fromARGB(100, 158, 158, 158),
                offset: Offset(0, 0))
          ],
          color: Colors.blue[100],
        ),
        child: Row(children: [
          SizedBox(
            height: width * 0.25,
            width: width * 0.3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: width * 0.2,
                  width: width * 0.2,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            blurStyle: BlurStyle.outer,
                            color: Color.fromARGB(255, 255, 254, 254),
                            offset: Offset(0, 0))
                      ],
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: const Color.fromARGB(255, 214, 226, 246),
                          width: 2),
                      shape: BoxShape.circle,
                      color: Colors.white),
                  child: image == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(width),
                          child: const Image(
                            image: AssetImage("assets/images/student.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(width),
                          child: Image(
                            image: FileImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                //Adding photo
                Positioned(
                  right: width * 0.025,
                  bottom: 5,
                  child: Container(
                    height: width * 0.08,
                    width: width * 0.1,
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(125, 9, 43, 101),
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      iconSize: width * 0.04,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Container(
            height: width * 0.180,
            width: width * 0.5,

            // ignore: prefer_const_constructors
            decoration: BoxDecoration(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "NANDHAKUMAR C",
                style: TextStyle(
                    fontSize: width * 0.05,
                    color: const Color.fromARGB(255, 4, 22, 50),
                    fontWeight: FontWeight.w600),
              ),
              Text("(nandha2402@gmail.com)",
                  style: TextStyle(
                      fontSize: width * 0.035, color: Colors.grey[600])),
              SizedBox(
                height: width * 0.007,
              ),
              Text("STUDENT",
                  style: TextStyle(
                      fontSize: width * 0.04, color: Colors.grey[900]))
            ]),
          )
        ]),
      ),
    );
  }
}
