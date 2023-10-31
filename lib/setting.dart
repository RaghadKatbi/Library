import 'package:flutter/material.dart';
import 'package:gold/profile_user.dart';

import 'l10n/app_localizations.dart';

class setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return setting_State();
  }

}
class setting_State extends State<setting>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)?.setting}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        // shadowColor: Colors.teal.withOpacity(0.9),
        backgroundColor: Colors.cyan.shade600,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 30,left: 3), child: Container(
            width: 350,
            height:50,
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => profile()));
              },
              child: Text("${AppLocalizations.of(context)?.myprofile}",style: TextStyle(color: Colors.black,fontSize: 20),),
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.black26;
                  else
                    return Colors.white;
                }),
              ),
            ),
          ),),
          Padding(padding: EdgeInsets.only(top: 10,left: 3), child: Container(
            width: 350,
            height:50,
            child: ElevatedButton(
              onPressed: (){},
              child: Text("Notification",style: TextStyle(color: Colors.black,fontSize: 20),),
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.black26;
                  else
                    return Colors.white;
                }),
              ),
            ),
          ),),
        ],
      ),
    );
  }

}