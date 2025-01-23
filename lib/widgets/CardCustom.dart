import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cardcustom extends StatefulWidget {
  const Cardcustom({super.key});

  @override
  State<Cardcustom> createState() => _CardcustomState();
}

class _CardcustomState extends State<Cardcustom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blue),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 200,
          width: 150,
          //color: Colors.blue,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              height: 120,
              width: 150,
              child: ClipRect(
                child: Image.asset(
                  "assets/img-2.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Joining a School Club",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Text("3-5 minutes"),
          ]),
        ),
        Align(
          child: FittedBox(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              color: Colors.green,
              child: Text(
                "EASY",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          alignment: Alignment.topLeft,
        ),
      ],
    );
  }
}
