import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';

class library_home extends StatefulWidget {
  final place_id;
  library_home(this.place_id);

  @override
  State<StatefulWidget> createState() {
    return library_home_State(place_id);
  }
}

class library_home_State extends State<library_home> {
  late String phone="",email="",address="",name="";
final place_id;
  library_home_State(this.place_id);
  void getData()
  {
    CollectionReference place = FirebaseFirestore.instance.collection('library');
    place.get().then((value) => value.docs.forEach((element) {
      setState(() {
        print("+++++++++++++++++++++++_____________________________________");
        if(element.get("id")==place_id)
        {
          name=element.get("place_name");
          address=element.get("address");
          email=element.get("email");
          phone=element.get("phone");
        }
      });
    }));
  }
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalizations.of(context)?.information_library}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        centerTitle: true,
        // shadowColor: Colors.teal.withOpacity(0.9),
        backgroundColor: Colors.cyan.shade600,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 25,bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)?.name_library} : $name",
                style: TextStyle(color: Colors.cyan, fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150, bottom: 10, top: 10),
              child: Text(
                "${AppLocalizations.of(context)?.addresslibrary} : $address",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  _openGmail();
                },
                child: Text(
                  "${AppLocalizations.of(context)?.libraryemail} :  $email",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20
                  ),
                ),
              )
            ),
            Padding(
                padding: const EdgeInsets.only(left: 140, bottom: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    _launchPhone();
                  },
                  child: Text(
                    "${AppLocalizations.of(context)?.libraryphone} : $phone",
                    style: TextStyle(
                        color: Colors.black, fontSize: 20
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
  _launchPhone() async {
    await FlutterPhoneDirectCaller.callNumber(phone);
  }
  void _openGmail() async {
    final gmailUrl = 'mailto:$email';
      await launch(gmailUrl);

  }
}