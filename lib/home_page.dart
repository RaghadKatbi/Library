import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'l10n/app_localizations.dart';

class home_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return home_page_State();
  }
}

class home_page_State extends State<home_page> {
  late List image = [];
  late List title = [];
  late List evaluation = [""];
  late List favorite = [];
  late List book_id = [];

  void getData() async {
    var userid = await FirebaseAuth.instance.currentUser!.uid;
//  print(userid);
    CollectionReference userInfo =
        FirebaseFirestore.instance.collection('user');
    userInfo
        .where('id', isEqualTo: userid)
        .get()
        .then((value) => value.docs.forEach((element) {
              //print(element.get('id'));
              userid = element.get('id');
            }));
    CollectionReference usr_bk =
        FirebaseFirestore.instance.collection('usr_book');
    usr_bk
        .where("user_id", isEqualTo: userid)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.get('book_id'));
              book_id.add(element.get('book_id'));
              evaluation.add(element.get('evalution'));
            //  print(book_id);
            }));
    CollectionReference book = FirebaseFirestore.instance.collection('Books');
   book.get().then((value) => value.docs.forEach((element) {
     for(int i=0;i<book_id.length;i++)
     if(element.get("id")==book_id[i])
      {
        print("++++++++++++++++++++++++");
        setState(() {
          print(title);
          print(image);
          title.add(element.get("Book_Tittle"));
          image.add(element.get("image"));
        });
      }
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
          title: Text("${AppLocalizations.of(context)?.myshelfbook}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
          centerTitle: true,
          // shadowColor: Colors.teal.withOpacity(0.9),
          backgroundColor: Colors.cyan.shade600,
        ),
        body:book_id.length != 0
            ? ListView.builder(
                itemCount: book_id.length,

                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 90,
                    child: Card(
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                              radius: 60,
                              child:   Container(
                                width: 260,
                                height:340,
                                child: CachedNetworkImage(
                                  imageUrl: image[index],
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),),),
                        ),
                        title: Text(title[index]),
                        subtitle: RatingBar(
                          initialRating: 3.4,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.amber),
                            half: Icon(Icons.star_half, color: Colors.amber),
                            empty: Icon(Icons.star_border, color: Colors.amber),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(
                child: Center(
                  child: Text("${AppLocalizations.of(context)?.there}"),
                ),
              ));
  }
}
