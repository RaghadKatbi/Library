import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
class publish extends StatefulWidget {
  final publish_id;
  publish(this.publish_id);
  @override
  State<StatefulWidget> createState() {
    return publish_State(publish_id);
  }
}

class publish_State extends State<publish> {
  @override
  String name="",address="",email="",phone="";
final publish_id;
  publish_State(this.publish_id);
  void getData()
  {
    CollectionReference Author = FirebaseFirestore.instance.collection('publish_hom');
    Author.get().then((value) => value.docs.forEach((element) {
      setState(() {
        print("+++++++++++++++++++++++_____________________________________");
        if(element.get("id")==publish_id)
        {
          name=element.get("publish_name");
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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalizations.of(context)?.publishhome}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        centerTitle: true,
        shadowColor: Colors.teal.withOpacity(0.9),
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
                "${AppLocalizations.of(context)?.publishname} : $name",
                style: TextStyle(color: Colors.cyan, fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140, bottom: 10, top: 10),
              child: Text(
                "${AppLocalizations.of(context)?.publishaddress} : $address",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140, bottom: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  _openGmail();
                },
                child: Text(
                  "${AppLocalizations.of(context)?.pubemail} : $email",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20
                  ),
                ),
              )
            ),    Padding(
              padding: const EdgeInsets.only(left: 140, bottom: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  _launchPhone();
                },
                child: Text(
                "${AppLocalizations.of(context)?.pubphone} :$phone",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20
                  ),
                ),
              )
            ),
           //launchUrl()
           //
          ],
        ),
      ),
    );
  }
  _launchPhone() async {
    await launch('tel:$phone');
  }
  void _openGmail() async {
    final gmailUrl = 'mailto:$email';
    await launch(gmailUrl);

  }
}
