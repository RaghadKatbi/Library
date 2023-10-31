import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gold/athor.dart';
import 'package:gold/publish_Home.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'l10n/app_localizations.dart';
import 'library_home.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
class book extends StatefulWidget {
  final title;

  book(this.title);

  @override
  State<StatefulWidget> createState() {
    return book_State(title);
  }
}

class book_State extends State<book> {
  late String book_tittle="",
      price="",
      decr="",
      pub_date="",
      num_page="",
      publish_id="",
      part="",
      classification_id="",
      place_id="",
      author_id="",
      book_id="",
      place_name="",
      author_name="",
      pub_name="",
      user_id="",
      readbk,
      user_opinion="",
     image="";
 late double evalotion=0.0;
  final title;


  book_State(this.title);
  Future<void> getPdfUrl() async {
  final directory = await getExternalStorageDirectory();
    Reference ref = FirebaseStorage.instance.ref().child("أربعون.pdf");
    String url = await ref.getDownloadURL();
    print(url);
  var userid= await FirebaseAuth.instance.currentUser!.uid;
  print(userid);
  int i=1;
  CollectionReference userInfo =FirebaseFirestore.instance.collection('user');
  userInfo.where('id',isEqualTo: userid).get().then((value) => value.docs.forEach((element) {
    print(element.get('id'));
    user_id=  element.get('id');
  }));
  CollectionReference usr_bk = FirebaseFirestore.instance.collection('usr_book');
  usr_bk.add({
    "usr_book_id":i,
    "book_id":book_id,
    "user_id":user_id,
    "evalution":2.3,
    "user_opinion":user_opinion,
    "visit_id":""
  });
    //  await FlutterDownloader.enqueue(
      //  url: url,
        //savedDir: '${directory!.path }',
       // fileName: title,
       // showNotification: true,
       // openFileFromNotification: true,
     // );

   // return url;
  }

  void getData() {
    CollectionReference book = FirebaseFirestore.instance.collection('Books');
    book.where("Book_Tittle",isEqualTo: title).get().then((value) => value.docs.forEach((element) {
          setState(() {
            print("+++++++++++++++++++++++");
            book_id = element.get("id");
       price = element.get("price");
          author_id = element.get("Author_id");
           book_tittle = element.get("Book_Tittle");
        num_page = element.get("Number of page");
       // classification_id = element.get("classification_id");
    //part = element.get("part");
     pub_date = element.get("publish_date");
    publish_id = element.get("publish_id");
       decr=element.get("Description");
     image=element.get("image");
   //   evalotion=element.get("evalotion");
      place_id=element.get("place_id");
            print(author_id);
          });
        }));
    CollectionReference Author = FirebaseFirestore.instance.collection('Author');
    Author.get().then((value) => value.docs.forEach((element) {
      setState(() {
    //    print("+++++++++++++++++++++++_____________________________________");
        if(element.get("id")==author_id)
          author_name=element.get("Author_name");
        print(author_id);
      });
    }));
    CollectionReference pub_home = FirebaseFirestore.instance.collection('publish_hom');
    pub_home.get().then((value) => value.docs.forEach((element) {
      setState(() {
    //    print("+++++++++++++++++");
        if(element.get("id")==publish_id)
          pub_name=element.get("publish_name");
      });
    }));

    CollectionReference place = FirebaseFirestore.instance.collection('library');
    place.get().then((value) => value.docs.forEach((element) {
      setState(() {
        print("libartttttt");
        print(element.get("place_name"));
        if(element.get("id")==place_id)
             place_name=element.get("place_name");
        print(place_id);
      });
    }));

  }
  void opinion()async{
    var userid= await FirebaseAuth.instance.currentUser!.uid;
    print(userid);

    CollectionReference userInfo =FirebaseFirestore.instance.collection('user');
    userInfo.where('id',isEqualTo: userid).get().then((value) => value.docs.forEach((element) {
     // print(element.get('id'));
      user_id=  element.get('id');
    }));
    String id;
    CollectionReference usr_bk = FirebaseFirestore.instance.collection('usr_book');
    usr_bk.get().then((value) => value.docs.forEach((element) {
      print(element.id);
      if(element.get("book_id")==book_id&&element.get("user_id")==user_id)
        {
        //  print(usr_bk.id);
          usr_bk.doc().set({
           "user_opinion":user_opinion
          });
        }
    }));

  }
  Future<void> read() async {
    var userid= await FirebaseAuth.instance.currentUser!.uid;
   // print(userid);
    int i=1;
    CollectionReference userInfo =FirebaseFirestore.instance.collection('user');
    userInfo.where('id',isEqualTo: userid).get().then((value) => value.docs.forEach((element) {
      print(element.get('id'));
      user_id=  element.get('id');
    }));
    bool f=false;
    CollectionReference usr_bk = FirebaseFirestore.instance.collection('usr_book');
    usr_bk.get().then((value) => value.docs.forEach((element) {if(book_id==element.get("book_id")) f=true ;}));
    if(f==false)
    usr_bk.add({
      "usr_book_id":i,
      "book_id":book_id,
      "user_id":user_id,
      "evalution":2.3,
      "user_opinion":user_opinion,
      "visit_id":""
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // print(title);
    var Rating;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 0),
              child: Row(
                children: [
                  Container(
                      width: 160,
                      height: 240,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60, top: 90),
                    child: Column(
                      children: [
                        Text(
                          "$title",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.cyan),
                        ),
                        RatingBarIndicator(
                            itemCount: 5,
                            rating: 3.5,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Colors.yellow,
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)?.desc} :",
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Text(
                "$decr",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => author(author_id)));
              },
              child: Text(
                "${AppLocalizations.of(context)?.author} : $author_name",
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)?.numberofpage}: $num_page",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)?.price}: $price",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)?.publishdate}: $pub_date",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => publish(publish_id)));
              },
              child: Text(
                "${AppLocalizations.of(context)?.publishhome} : $pub_name",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => library_home(place_id)));
              },
              child: Text(
                "${AppLocalizations.of(context)?.find} : $place_name",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
            Container(
              height: 120,
              width: double.infinity,
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    user_opinion=val;
                  });
                },
                maxLines: 100,
                cursorColor: Colors.teal,
                style: TextStyle(
                  color: Colors.cyan.shade700,
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.open_in_browser_sharp,
                      color: Colors.teal,
                    ),
                    labelText: "${AppLocalizations.of(context)?.type}",
                    labelStyle: TextStyle(color: Colors.teal),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none))),
                keyboardType: TextInputType.text,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: RatingBar.builder(
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,
                      );
                    },
                    onRatingUpdate: (value) {
                      Rating = value;
                      print(Rating);
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      opinion();
                    },
                    child: Text(
                      "${AppLocalizations.of(context)?.type}",
                      style: TextStyle(fontSize: 10),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.cyanAccent[500];
                        else
                          return Colors.cyanAccent[500];
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, top: 10, right: 60.0),
              child: Container(
                height: 60,
                width: 220,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckout(
                        sandboxMode: true,
                        clientId:
                            "AbFNrzvm9XpD8eeMpiWKnwyOd4UKaJ2DoWtX_xuk-9-tD9c-pdNN_tosInHOxn7inyOAF6V_h5KMw-KG",
                        secretKey:
                            "EKSx6b34smuUxOsesSVuqSiExGEqePzxuRmA0tx9FYAS9bJ8ny7RXgBarZNhi1Xfa9Rd5u1vXq0R5-tZ",
                        returnURL: "success.snippetcoder.com",
                        cancelURL: "cancel.snippetcoder.com",
                        transactions: const [
                          {
                            "amount": {
                              "total": '70',
                              "currency": "USD",
                              "details": {
                                "subtotal": '70',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description": "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {
                              "items": [
                                {
                                  "name": "Apple",
                                  "quantity": 4,
                                  "price": '5',
                                  "currency": "USD"
                                },
                                {
                                  "name": "Pineapple",
                                  "quantity": 5,
                                  "price": '10',
                                  "currency": "USD"
                                }
                              ],

                              // shipping address is not required though
                              //   "shipping_address": {
                              //     "recipient_name": "Raman Singh",
                              //     "line1": "Delhi",
                              //     "line2": "",
                              //     "city": "Delhi",
                              //     "country_code": "IN",
                              //     "postal_code": "11001",
                              //     "phone": "+00000000",
                              //     "state": "Texas"
                              //  },
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          print("onSuccess: $params");
                        },
                        onError: (error) {
                          print("onError: $error");
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          print('cancelled:');
                        },
                      ),
                    ));
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    "${AppLocalizations.of(context)?.pay}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 55.0, top: 15, right: 55, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            getPdfUrl();
                         // String url= getPdfUrl() as String;

                          },
                          child: Text(
                            "${AppLocalizations.of(context)?.download}",
                            style: TextStyle(fontSize: 15),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.cyanAccent[500];
                              else
                                return Colors.cyanAccent[500];
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
