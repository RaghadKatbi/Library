import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'l10n/app_localizations.dart';

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profile_state();
  }
}

class profile_state extends State<profile> {
  late String Email="", password="", username="", phone="", age="", Verify="", gender="",id="";
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: userid)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("=============");
          username = element.get('username');
          phone=element.get('phone');
          password = element.get('password');
          age=element.get('age');
          Email=element.get('email');
          gender=element.get('gender');
        });
      });
    });
    Reference ref = FirebaseStorage.instance.ref().child("Mask group.png");
    url = await ref.getDownloadURL();
  }
  late String url="";
  void initState() {

    print(url);
    getData();
    super.initState();
  }
  void update() async {
    id= await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userinfo =
    FirebaseFirestore.instance.collection("user");
    userinfo.get().then((value) => value.docs.forEach((element) {
     setState(() {
       print("+++++++++++++++++++");
       if(element.get("id")==id)
         id=element.id;
       print(element.id);
     });
    }));
    setState(() {
      print("=================");
      print('$id');
      userinfo.doc(id).set({
        "username": username,
        "email": Email,
        "id": id,
        "phone": phone,
        "age":age,
        "password": password,
        "gender": gender,
      });
    });
  }
  var image = File(
      '/data/user/0/com.example.gold/cache/519f9ff7-5420-428d-8938-daf604cafd16/IMG_20230813_102745_338.jpg');
  final picker = ImagePicker();
  bool uploading = false;

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.teal.withOpacity(0.1),
              Colors.lightBlueAccent.withOpacity(0.15),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Center(
                  child: url==""
                      ? Stack(
                          children: [
                            Container(
                              width: 230.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/icon.jpg"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  iconSize: 37,
                                  onPressed: () {
                                    setState(() {
                                      getImagefromGallery();
                                    });
                                  }),
                            ),
                          ],
                        )
                      : Stack(children: [
                          Container(
                            width: 230,
                            height: 180,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(image),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8,top: 120),
                            child: IconButton(
                                icon: Icon(Icons.camera_alt),
                                iconSize: 37,
                                onPressed: () {
                                  setState(() {
                                    getImagefromGallery();
                                  });
                                }),
                          ),
                        ])),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "${AppLocalizations.of(context)?.personal}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      username = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Colors.teal,
                      ),
                      labelText: "${username}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[A-z]'))
                  ],
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      Email = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.teal,
                      ),
                      labelText: "${Email}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.teal,
                      ),
                      labelText: "${phone}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      age = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.boy,
                        color: Colors.teal,
                      ),
                      labelText: "${age}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[1-9]'))
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      gender = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.girl,
                        color: Colors.teal,
                      ),
                      labelText: "${gender}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[A-z]'))
                  ],
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0, bottom: 20,left: 12),
                child: Text(
                  "${AppLocalizations.of(context)?.change}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.teal,
                      ),
                      labelText: "${password}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      Verify = val;
                    });
                  },
                  cursorColor: Colors.teal,
                  style: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.teal,
                      ),
                      labelText: "${password}" ,
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: ElevatedButton(
                      child: Text(
                        "Update",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.black26;
                            else
                              return Colors.cyan.shade700;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                      onPressed: () {
                        update();
                      },
                    ),
                  )),
            ])),
      ),
    ));
  }

  getImagefromGallery() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
        print(image);
      });
      setState(() {
        uploading = true;
      });
    } else
      print("No image Selected");
  }
}
