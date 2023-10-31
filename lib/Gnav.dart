import 'package:flutter/material.dart';
import 'package:gold/Authors.dart';
import 'package:gold/books.dart';
import 'package:gold/library_book.dart';
import 'package:gold/home_page.dart';
import 'package:gold/profile_user.dart';
import 'package:gold/setting.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'l10n/app_localizations.dart';

class Gnav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Gnav_State();
  }
}

class Gnav_State extends State<Gnav> {
  late int _page = 0;
  List<Widget> pages = [home_page(), books(),Authors(), library_book(), profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: Container(
        height: 52,
        width: double.infinity,
        child: GNav(
          padding: EdgeInsets.all(16),
          gap: 8,
          tabs: [
            GButton(
              icon: Icons.book_outlined,
              text: "${AppLocalizations.of(context)?.mybook}",
            ),
            GButton(
              icon: Icons.catching_pokemon_outlined,
              text: "${AppLocalizations.of(context)?.books}",
            ),
            GButton(
              icon: Icons.pending_outlined,
              text:  "${AppLocalizations.of(context)?.authors}",
            ),
            GButton(
                icon: Icons.location_on_outlined, text:  "${AppLocalizations.of(context)?.location}",),
            GButton(
              icon: Icons.person,
              text:  "${AppLocalizations.of(context)?.myprofile}",
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.15),
          activeColor: Colors.cyan.shade700,
          color: Colors.cyan.shade700,
          tabBackgroundColor: Colors.cyan.withOpacity(0.25),
          tabBorder: Border.all(color: Colors.cyan, width: 0),
          // tab button border
          tabShadow: [
            BoxShadow(color: Colors.teal.withOpacity(0.1), blurRadius: 10)
          ],
          onTabChange: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
      ),
    );
  }
}
