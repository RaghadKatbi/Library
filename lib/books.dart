import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'book.dart';
import 'l10n/app_localizations.dart';

class books extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return books_State();
  }
}

class books_State extends State<books> {
  late List image = [];
  late List category = [];
  late List author = [];
  late List title = [];
  late List author_id = [];

  void getData() {
    int i = 0;
    CollectionReference book = FirebaseFirestore.instance.collection('Books');
    book.get().then((value) => value.docs.forEach((element) {
          setState(() {
            print("___________________");
            image.add(element.get("image"));
            // category.add(element.get("Category"));
            title.add(element.get("Book_Tittle"));
            author_id.add(element.get("Author_id"));
            print("++++++++++++++++++++++++++");
            print(title);
            print(image);
          });
        }));
    CollectionReference Author =
        FirebaseFirestore.instance.collection('Author');
    Author.get().then((value) => value.docs.forEach((element) {
      for(int i=0;i<author_id.length;i++)
        if(author_id[i]==element.get("id"))
          author.add(element.get("Author_name"));
          print(author);
        }));
  }

  void initState() {
    print("+++++++++++++++");
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
            "${AppLocalizations.of(context)?.books}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          centerTitle: true,
          // shadowColor: Colors.teal.withOpacity(0.9),
          backgroundColor: Colors.cyan.shade600,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "${AppLocalizations.of(context)?.booksfromthis}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
      ListView.builder(
          shrinkWrap: true,
          itemCount: image.length,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: width,
                height: height * 0.2,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => book(title[index])));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.35,
                          child: CachedNetworkImage(
                            imageUrl: image[index],
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 58.0,left: 20,right: 20),
                              child: Text(
                                "${title[index]}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),

                          ],
                        )
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
                    ))),
          );
          },
      ),
            ],
          ),
        ));
  }
}
