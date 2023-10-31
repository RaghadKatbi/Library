import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gold/Sign_up.dart';
import 'package:gold/Gnav.dart';

import 'l10n/app_localizations.dart';
//import 'package:gold/l10n/app_localizations.dart';
class SignInUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Login_State();
  }
}

class Login_State extends State<SignInUser> {
  @override
  late String Email="${AppLocalizations.of(context)?.email}";
  late String password;
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration : BoxDecoration(gradient: LinearGradient( colors: [
            Colors.teal.withOpacity(0.1),
            Colors.lightBlueAccent.withOpacity(0.15),
          ],
              begin: Alignment.topCenter, end: Alignment.bottomCenter
          )),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, height * 0.1, 20, 0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Image.asset("images/logo.png",
                        width: width*0.5,
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              Email = val;
                            });
                          },
                          cursorColor: Colors.teal,
                          style: TextStyle(
                            color: Colors.cyan.shade600,
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
                                  borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                   )
                                   ),
                          keyboardType: TextInputType.emailAddress,
                        )
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      cursorColor: Colors.teal,
                      style: TextStyle(
                        color: Colors.cyan.shade600,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.teal,
                          ),
                         labelText: AppLocalizations.of(context)?.password,
                          labelStyle: TextStyle(color: Colors.teal),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
                      keyboardType: TextInputType.visiblePassword,

                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child:Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                          child: ElevatedButton(
                              child: Text(
                                "${AppLocalizations.of(context)?.signin}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                           //    "${AppLocalizations.of(context)?.email}",
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Colors.black26;
                                    else
                                      return Colors.cyan.shade700;
                                  }),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                              onPressed: () async {
                                var user;
                                  try {
                                    user = await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                        email: Email, password: password);
                                    print("++++++++++++++++++++++++++++++++++++++++++++");
                                    print(Email);
                                  }
                                  catch (e) {
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
                               if(user!=null)
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => Gnav()));
                              },
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                           "${AppLocalizations.of(context)?.donthave}",
                        //  "${AppLocalizations.of(context)?.email}",
                          style: TextStyle(color: Colors.teal),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("++++++++++++++++++++");
                            print(Email);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => singUpUser()));

                          },
                          child:  Text(
                            "${AppLocalizations.of(context)?.signup}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}