import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gold/Gnav.dart';

import 'l10n/app_localizations.dart';

class singUpUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return singUpUser_state();
  }
}

class singUpUser_state extends State<singUpUser> {
  late String Email, password, username, phone, age, Verify, gender;

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.teal.withOpacity(0.1),
            Colors.lightBlueAccent.withOpacity(0.15),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(children: [
              Container(
                height: height * 0.17,
                width: double.infinity,
                child: Image.asset("images/logo.png"),
              ),
              Text(
                "${AppLocalizations.of(context)?.create}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade700),
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
                      labelText: "${AppLocalizations.of(context)?.user}",
                      labelStyle: TextStyle(color: Colors.teal),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
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
                      labelText: "${AppLocalizations.of(context)?.email}",
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
                      labelText: "${AppLocalizations.of(context)?.phone}",
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
                      labelText: "${AppLocalizations.of(context)?.age}",
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
                      labelText: "${AppLocalizations.of(context)?.gender}",
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
                      labelText: "${AppLocalizations.of(context)?.password}",
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
                      labelText: "${AppLocalizations.of(context)?.verify}",
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
                        "${AppLocalizations.of(context)?.signup}",
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
                      onPressed: () async {
                        if (Verify == password)
                          try {
                            var user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: Email, password: password);

                            addData();
                            if (user != null)
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return Gnav();
                              }));
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text(
                                    "The Password isn't the same verify password"),
                                actions: [
                                  ElevatedButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  )),
            ]),
          )),
    ));
  }

  addData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference user = FirebaseFirestore.instance.collection("user");
    user.add({
      "id": userid,
      "username": username,
      "email": Email,
      "phone": phone,
      "password": password,
      "age": age,
      "gender": gender,
      "image": ""
    });
  }
}
