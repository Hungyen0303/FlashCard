import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contentchatcontainer extends StatelessWidget {
   Contentchatcontainer({super.key, required this.isBot, required this.content});
  final bool isBot ;
  final String content;

  @override
  Widget build(BuildContext context) {
    return isBot ?  Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/apple-icon.png" ,width:  45,),
            ),
          ) ,
          IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  minWidth: MediaQuery.of(context).size.width * 0.3),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 10, top: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: Text(content) ,
            ),
          ),
        ],
      ),
    ) : Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.3),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 10, top: 20),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Text(content) ,
        ),
      ),
    ) ;

  }
}
