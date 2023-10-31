import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold/athor.dart';

import 'l10n/app_localizations.dart';

class Authors extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Authors_State();
  }

}


class Authors_State extends State<Authors>{
  late List author_name=[];
  late List author_id=[];
  late List image=[];
  void getData()
  {
    CollectionReference Author = FirebaseFirestore.instance.collection('Author');
    Author.get().then((value) => value.docs.forEach((element) {
      setState(() {
        print("+++++++++++++++++++++++_____________________________________");

          image.add(element.get("image"));
          author_name.add(element.get("Author_name"));
          author_id.add(element.get("id"));
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)?.authors}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        // shadowColor: Colors.teal.withOpacity(0.9),
        backgroundColor: Colors.cyan.shade600,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: image.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: width,
                height: height * 0.2,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => author(author_id[index])));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.35,
                          height: 140,
                          child: CachedNetworkImage(
                            imageUrl: image[index],
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${author_name[index]}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.white;
                        else
                          return Colors.white;
                      }),
                    )));
          },
        ),
      ),
    );
  }

}
