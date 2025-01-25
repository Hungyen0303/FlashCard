import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cardcustom extends StatefulWidget {
  const Cardcustom({super.key, required this.image, required this.title, required this.start, required this.end, required this.level});

  final String image ;
  final String title ;
  final int start ;
  final int  end ;
  final String level ;
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
          //padding: EdgeInsets.only(bottom: 8),
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blue),
          height: 210,
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
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: Text(
               widget.title,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                "${widget.start}-${widget.end} minutes",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        Align(
          child: FittedBox(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              color: Colors.green,
              child: Text(
                "${widget.level}",
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
