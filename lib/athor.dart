import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

class author extends StatefulWidget {
  final author_id;
  author(String this.author_id);

  @override
  State<StatefulWidget> createState() {
    return author_State(author_id);
  }
}

class author_State extends State<author> {
  final author_id;
  author_State(this.author_id);
late String image="",name="",education="",birth="",about="";
void getData()
{
  CollectionReference Author = FirebaseFirestore.instance.collection('Author');
  Author.get().then((value) => value.docs.forEach((element) {
    setState(() {
      print("+++++++++++++++++++++++_____________________________________");
      if(element.get("id")==author_id)
        {
          name=element.get("Author_name");
          about=element.get("about");
          education=element.get("education");
          birth=element.get("birthday");
          image=element.get("image");
        }

      print(author_id);
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
        title: Text("${AppLocalizations.of(context)?.author}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        centerTitle: true,
        // shadowColor: Colors.teal.withOpacity(0.9),
        backgroundColor: Colors.cyan.shade600,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Container(
                    width: 230,
                    height: 180,
                  child:  CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 25),
                child: Text(
                  "${AppLocalizations.of(context)?.authorname} : $name",
                  style: TextStyle(color: Colors.cyan, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
                child: Text(
                  "${AppLocalizations.of(context)?.education} : \ $education",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,bottom: 10, top: 10),
                child: Text(
                  "${AppLocalizations.of(context)?.authorbirthday} : $birth",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
                child: Text(
                  "${AppLocalizations.of(context)?.about} : $about",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
